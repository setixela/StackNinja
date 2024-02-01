//
//  StackModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 21.06.2022.
//

import ReactiveWorks
import UIKit

open class VStackModel: StackModel {
   override open func start() {
      super.start()
   }
}

open class HStackModel: StackModel {
   override open func start() {
      super.start()

      axis(.horizontal)
   }
}

open class StackModel: BaseViewModel<StackViewExtended> {
   public convenience init(_ models: UIViewModel...) {
      self.init()

      arrangedModels(models)
   }

    public convenience init(_ models: [UIViewModel]) {
        self.init()

        arrangedModels(models)
    }

   override open func start() {
      axis(.vertical)
   }
    
   public typealias X = HStackModel
   
   public typealias Y = VStackModel
}

extension StackModel: Stateable2 {
   public typealias State = StackState
   public typealias State2 = ViewState
}

public extension StackViewExtended {
   func removeAllSubviews() {
      let removedSubviews = arrangedSubviews.reduce([]) { subview, next -> [UIView] in
         removeArrangedSubview(next)
         return subview + [next]
      }
      NSLayoutConstraint.deactivate(removedSubviews.flatMap(\.constraints))
      removedSubviews.forEach { $0.removeFromSuperview() }
      NSLayoutConstraint.deactivate(subviews.flatMap(\.constraints))
      subviews.forEach { $0.removeFromSuperview() }
   }
}
