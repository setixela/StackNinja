//
//  SelfModable.swift
//
//
//  Created by Aleksandr Solovyev on 10.08.2022.
//

import ReactiveWorks

public protocol WeakSelfied: InitProtocol {
   associatedtype WeakSelf
}

public protocol SelfModable: AnyObject {
   associatedtype SelfMode: WeakSelfied

   var selfMode: SelfMode { get set }
}

public extension SelfModable {
   @discardableResult
   func onModeChanged(_ keypath: WritableKeyPath<SelfMode, Event<SelfMode.WeakSelf>?>,
                      _ block: Event<SelfMode.WeakSelf>?) -> Self where SelfMode.WeakSelf == Self
   {
      selfMode[keyPath: keypath] = block

      return self
   }

   @discardableResult
   func setMode(_ keypath: KeyPath<SelfMode, Event<SelfMode.WeakSelf>?>) -> Self where SelfMode.WeakSelf == Self {
      let mode = selfMode[keyPath: keypath]

      weak var slf = self
      guard let slf else { return self }

      mode?(slf)

      return self
   }
}

public protocol ModeProtocol: InitProtocol {}

public protocol Modable: AnyObject {
   associatedtype Mode: ModeProtocol

   var modes: Mode { get set }
}

public extension Modable {
   @discardableResult
   func onModeChanged(_ keypath: WritableKeyPath<Mode, GenericClosure<Void>?>,
                      _ block: GenericClosure<Void>?) -> Self
   {
      modes[keyPath: keypath] = block

      return self
   }

   @discardableResult
   func setMode(_ keypath: KeyPath<Mode, GenericClosure<Void>?>) -> Self {
      let mode = modes[keyPath: keypath]

      mode?(())

      return self
   }
}
