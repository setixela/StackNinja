//
//  LabelSwitcher.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 22.08.2022.
//

import ReactiveWorks
import UIKit

open class LabelSwitcherX: StackNinja<SComboMR<LabelModel, WrappedY<Switcher>>> {
   public var label: LabelModel { models.main }
   public var switcher: Switcher { models.right.subModel }

   override open func start() {
      setAll { _, _ in
       
      }

      alignment(.center)
      axis(.horizontal)
   }
}

public extension LabelSwitcherX {
   static func switcherWith(text: String, isTurned: Bool = false) -> Self {
      Self()
         .setAll { label, switcher in
            label
               .text(text)
            switcher.subModel
               .setState(.turned(isTurned))
         }
   }
}
