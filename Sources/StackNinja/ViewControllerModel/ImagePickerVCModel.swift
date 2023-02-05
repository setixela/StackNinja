//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 04.02.2023.
//

import ReactiveWorks
import UIKit

public final class ImagePickerVCModel: UIImagePickerController, VCModelProtocol, Eventable {
   
   public var currentBarStyle: UIBarStyle?
   public var currentBarTintColor: UIColor?
   public var currentTitleColor: UIColor?
   public var currentBarTranslucent: Bool?
   public var currentBarBackColor: UIColor?
   public var currentTitleAlpha: CGFloat?
   public var currentStatusBarStyle: UIStatusBarStyle?

   public var events = EventsStore()

   public let sceneModel: SceneModelProtocol

   public lazy var baseView: UIView = sceneModel.makeMainView()
   
   public var isFirstAppear: Bool = true

   public required init(sceneModel: SceneModelProtocol) {
      self.sceneModel = sceneModel

      super.init(nibName: nil, bundle: nil)

      if UIImagePickerController.isSourceTypeAvailable(.camera) {
         sourceType = .camera
      } else {
         sourceType = .photoLibrary
      }

      allowsEditing = false
   }

   override public func loadView() {
      view = baseView
   }

   @available(*, unavailable)
   public required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
