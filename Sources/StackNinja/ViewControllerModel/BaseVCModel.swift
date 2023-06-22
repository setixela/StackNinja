//
//  BaseVCModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 04.06.2022.
//

import UIKit
import ReactiveWorks

open class BaseVCModel: UIViewController, VCModelProtocol {
   public let sceneModel: SceneModelProtocol

   public lazy var baseView: UIView = sceneModel.makeMainView()

   public var events: EventsStore = .init()

   public var currentStatusBarStyle: UIStatusBarStyle?
   public var currentBarStyle: UIBarStyle?
   public var currentBarTintColor: UIColor?
   public var currentTitleColor: UIColor?
   public var currentBarTranslucent: Bool?
   public var currentBarBackColor: UIColor?
   public var currentTitleAlpha: CGFloat?
   public var currentBackColor: UIColor?
   
   public internal(set) var isFirstAppear = true

   override open var preferredStatusBarStyle: UIStatusBarStyle {
      currentStatusBarStyle ?? .default
   }

   public required init(sceneModel: SceneModelProtocol) {
      self.sceneModel = sceneModel

      super.init(nibName: nil, bundle: nil)
   }

   override public func loadView() {
      view = baseView
   }

   @available(*, unavailable)
   public required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
