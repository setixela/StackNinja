//
//  VCModelProtocol.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public struct VCEvent: InitProtocol {
   public var updateInputAfterLoad: Void?
   public var viewWillAppear: Void?
   public var viewDidAppear: Void?
   public var viewWillDissappear: Void?
   
   public var viewWillAppearByBackButton: Void?

   public var dismiss: Void?

   public var motionEnded: UIEvent.EventSubtype?
   //
   public init() {}
}

public protocol VCModelProtocol: UIViewController, Eventable where Events == VCEvent {
   var sceneModel: SceneModelProtocol { get }
   //
   var currentStatusBarStyle: UIStatusBarStyle? { get set }
   var currentBarStyle: UIBarStyle? { get set }
   var currentBarTintColor: UIColor? { get set }
   var currentTitleColor: UIColor? { get set }
   var currentBarTranslucent: Bool? { get set }
   var currentBarBackColor: UIColor? { get set }
   var currentTitleAlpha: CGFloat? { get set }
   
   var isFirstAppear: Bool { get }

   init(sceneModel: SceneModelProtocol)
}
