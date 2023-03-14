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
        get {
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
    }

    override public func start() {
        on(\.presentOn) { [weak self] vc in
            guard let picker = self?.picker else { return }

            let photoLibraryAction = UIAlertAction(title: "Выбрать  фото", style: .default) {
                _ in
                //   picker.sourceType = .photoLibrary
                vc?.present(picker, animated: true)
            }

            let cameraAction = UIAlertAction(title: "Сделать снимок", style: .default) {
                _ in
                //  picker.sourceType = .camera
                vc?.present(picker, animated: true)
            }

            let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)

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

        results
            .compactMap { $0.itemProvider }
            .forEach {
                $0.loadObject(
                    ofClass: UIImage.self) { [weak self] reading, error in
                        if let image = reading as? UIImage {
                            self?.send(\.didImagePicked, image)
                        }
                    }
            }

        clearPicker()
    }
    
    
    private func clearPicker() {
        _picker = nil
    }
}
