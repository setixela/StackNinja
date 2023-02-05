//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 04.02.2023.
//

import Foundation
import ReactiveWorks

public struct SelectableButtonEvents: InitProtocol {
   public init() {}

   public var didSelected: Bool?
}

open class SelectableButton: BaseViewModel<ButtonExtended>, SelfModable, Eventable, ButtonTapAnimator {
   public typealias Events = SelectableButtonEvents

   public var events: EventsStore = .init()

   public var selfMode: SelfMode = .init()

   public private(set) var isSelected = false {
      didSet {
         if !isSelected {
            setMode(\.normal)
            send(\.didSelected, false)
         } else {
            setMode(\.selected)
            send(\.didSelected, true)
         }
      }
   }

   public struct SelfMode: WeakSelfied {
      public init() {}

      public typealias WeakSelf = SelectableButton

      public var normal: Event<WeakSelf>?
      public var inactive: Event<WeakSelf>?
      public var selected: Event<WeakSelf>?
   }

   override open func start() {
      view.addTarget(self, action: #selector(didTap), for: .touchUpInside)
   }

   @objc public func didTap() {
      if view.isEnabled {
         animateTap(uiView: uiView)

         isSelected = !isSelected

         print("Did tap")
      }
   }

   @discardableResult
   public func setSelected(_ isSelected: Bool) -> Self {
      self.isSelected = isSelected
      return self
   }
}

extension SelectableButton: Stateable2 {
   public typealias State = ViewState
   public typealias State2 = ButtonState
}
