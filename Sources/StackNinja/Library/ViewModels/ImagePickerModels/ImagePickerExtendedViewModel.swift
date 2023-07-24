//
//  ImagePickerExtendedViewModel.swift
//
//
//  Created by Aleksandr Solovyev on 14.03.2023.
//

import PhotosUI
import ReactiveWorks

public struct ImagePickerExtendedEvents: InitProtocol {
   public init() {}

   public var presentOn: UIViewController??
   public var didCancel: Void?
   public var didImagePicked: UIImage?
   public var didImagePickingError: Void?
}

public final class ImagePickerExtendedViewModel: BaseModel, Eventable {
   public typealias Events = ImagePickerEvents
   public var events = EventsStore()

   private var _picker: PHPickerViewController?

   private var limit: Int = 10

   private var picker: PHPickerViewController {
      guard let _picker else {
         var config = PHPickerConfiguration()
         config.filter = .images
         config.selectionLimit = limit

         let picker = PHPickerViewController(configuration: config)
         picker.delegate = self
         _picker = picker
         return picker
      }

      return _picker
   }

   private var _legacyPicker: UIImagePickerController?

   private var legacyPicker: UIImagePickerController {
      guard let _legacyPicker else {
         let picker = UIImagePickerController()
         picker.delegate = self
         picker.sourceType = .camera
         _legacyPicker = picker

         return picker
      }

      return _legacyPicker
   }

   private let selectPhotoText: String
   private let takePhotoText: String
   private let cancelText: String

   public init(selectPhotoText: String, takePhotoText: String, cancelText: String) {
      self.selectPhotoText = selectPhotoText
      self.takePhotoText = takePhotoText
      self.cancelText = cancelText

      super.init()
   }

   required init() {
      fatalError("init() has not been implemented")
   }

   override public func start() {
      on(\.presentOn) { [weak self] (vc: UIViewController?) in
         guard let self else { return }
         let picker = self.picker

         let photoLibraryAction = UIAlertAction(title: self.selectPhotoText, style: .default) {
            _ in
            vc?.present(picker, animated: true)
         }

         let cameraAction = UIAlertAction(title: self.takePhotoText, style: .default) {
            [weak self] _ in
            guard let picker = self?.legacyPicker else { return }

            vc?.present(picker, animated: true)
         }

         let cancelAction = UIAlertAction(title: self.cancelText, style: .cancel) { [weak self] _ in
            self?.send(\.didCancel)
         }

         let dialogMessage = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

         dialogMessage.addAction(photoLibraryAction)
         dialogMessage.addAction(cameraAction)
         dialogMessage.addAction(cancelAction)

         if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            var topVC = rootVC
            while let presentedVC = topVC.presentedViewController {
               topVC = presentedVC
            }
            topVC.present(dialogMessage, animated: true, completion: nil)
         }

         vc?.view.endEditing(true)
      }
   }

   @discardableResult
   public func setLimit(_ value: Int) -> Self {
      limit = value
      return self
   }
}

extension ImagePickerExtendedViewModel: PHPickerViewControllerDelegate {
   public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
      if results.isEmpty {
         send(\.didCancel)
      }

      results
         .map(\.itemProvider)
         .forEach {
            $0.loadObject(
               ofClass: UIImage.self)
            { [weak self] reading, _ in
               if let image = reading as? UIImage {
                  self?.send(\.didImagePicked, image)
               }
            }
         }

      clearPicker()
   }

   @discardableResult
   public func allowsEditing() -> Self {
      legacyPicker.allowsEditing = true
      return self
   }

   private func clearPicker() {
      _picker = nil
      _legacyPicker = nil
   }
}

extension ImagePickerExtendedViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true)
      send(\.didCancel)
   }

   public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      picker.dismiss(animated: true)

      guard let image = info[.originalImage] as? UIImage else {
         send(\.didImagePickingError)
         return
      }

      send(\.didImagePicked, image)

      if picker.allowsEditing == true {
         guard let croppedImage = info[.editedImage] as? UIImage else {
            send(\.didImagePickingError)
            return
         }
         send(\.didImageCropped, croppedImage)
      }
   }
}
