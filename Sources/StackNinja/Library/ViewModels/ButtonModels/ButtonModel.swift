//
//  ButtonModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 22.06.2022.
//

import Anchorage
import ReactiveWorks
import UIKit

public protocol ButtonModelProtocol: ViewModelProtocol, InitProtocol, Eventable, Stateable2
   where Events == ButtonEvents, State2 == ButtonState {}

public protocol ModableStackButtonModelProtocol: ModableButtonModelProtocol, Stateable2
   where Events == ButtonEvents, State == StackState, State2 == ButtonState {}

public protocol ModableButtonModelProtocol: ButtonModelProtocol, Modable where Mode == ButtonMode {}

open class ButtonModel: BaseViewModel<ButtonExtended>, ButtonModelProtocol {

   public typealias Events = ButtonEvents

   public var events = EventsStore()

   override open func start() {
      view.addTarget(self, action: #selector(didTap), for: .touchUpInside)
   }

   @objc func didTap() {
      if view.isEnabled {
         send(\.didTap)
         print("Did tap")

         animateTap(uiView: uiView)
      }
   }
}

extension ButtonModel: Stateable2 {
   public typealias State = ViewState
   public typealias State2 = ButtonState
}

extension ButtonModel: Eventable, ButtonTapAnimator {}

open class ModableButton: ButtonModel, ModableButtonModelProtocol {
   public var modes: ButtonMode = .init()
}

open class ButtonSelfModable: ButtonModel, SelfModable {
   public var selfMode: SelfMode = .init()

   public struct SelfMode: WeakSelfied {
      public init() {}

      public typealias WeakSelf = ButtonSelfModable

      public var normal: Event<WeakSelf>?
      public var inactive: Event<WeakSelf>?
      public var selected: Event<WeakSelf>?
      public var awaitng: Event<WeakSelf>?
   }
}

public struct ButtonMode: ModeProtocol {
   public init() {}

   public var normal: Event<Void>?
   public var selected: Event<Void>?
   public var inactive: Event<Void>?
}
