//
//  Switcher.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 22.08.2022.
//

import ReactiveWorks
import UIKit

public enum SwitcherState {
   case turnOn
   case turnOff
   case turned(Bool)
}

public final class Switcher: BaseViewModel<UISwitch>, Eventable, Stateable {
   public typealias State = ViewState

   public typealias Events = SwitchEvent
   public var events: EventsStore = .init()

   override public func start() {
      view.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
   }

   @objc private func didSwitch() {
      if view.isOn {
         send(\.turnedOn)
         send(\.turned, true)
      } else {
         send(\.turnedOff)
         send(\.turned, false)
      }
   }
}

extension Switcher: StateMachine {
   public func setState(_ state: SwitcherState) {
      switch state {
      case .turnOn:
         view.setOn(true, animated: true)
      case .turnOff:
         view.setOn(false, animated: true)
      case .turned(let value):
         view.setOn(value, animated: true)
      }
   }
}
