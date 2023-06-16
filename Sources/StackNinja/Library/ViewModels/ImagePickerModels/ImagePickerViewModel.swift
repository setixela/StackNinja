//
//  ImagePickerViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 31.08.2022.
//

import ReactiveWorks
import UIKit

public struct ImagePickerEvents: InitProtocol {
   public init() {}

   public var presentOn: UIViewController??
   public var didCancel: Void?
   public var didImagePicked: UIImage?
   public var didImagePickingError: Void?
   public var didImageCropped: UIImage?
}

public final class ImagePickerViewModel: BaseModel, Eventable {
   public typealias Events = ImagePickerEvents
   public var events = EventsStore()

   private lazy var picker = UIImagePickerController()

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
      picker.delegate = self

      on(\.presentOn) { [weak self] vc in
         guard let self else { return }

         let picker = self.picker

         let photoLibraryAction = UIAlertAction(title: self.selectPhotoText, style: .default) {
            _ in
            picker.sourceType = .photoLibrary
            vc?.present(picker, animated: true)
         }

         let cameraAction = UIAlertAction(title: self.takePhotoText, style: .default) {
            _ in
            picker.sourceType = .camera
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
   public func allowsEditing() -> Self {
      picker.allowsEditing = true
      return self
   }
}

extension ImagePickerViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
