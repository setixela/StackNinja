//
//  LabelModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 21.06.2022.
//

import ReactiveWorks

import UIKit

open class LabelModel: BaseViewModel<PaddingLabel>, Eventable {
   public typealias Events = ButtonEvents
   public var events = [Int: LambdaProtocol?]()

   @discardableResult
   public func makeTappable() -> Self {
      let labelTap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
      view.isUserInteractionEnabled = true
      view.addGestureRecognizer(labelTap)
      return self
   }

   @objc func labelTapped(_: UITapGestureRecognizer) {
      send(\.didTap)
   }
}

extension LabelModel: Stateable2 {
   public typealias State = LabelState
   public typealias State2 = ViewState
}
