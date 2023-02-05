//
//  TitleBodySwitcher.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 22.08.2022.
//

import ReactiveWorks
import UIKit

open class TitleBodySwitcherY: StackNinja<SComboMD<LabelModel, LabelSwitcherX>> {
   public var title: LabelModel { models.main }
   public var body: LabelModel { models.down.label }
   public var switcher: Switcher { models.down.switcher }

   override open func start() {
      setAll { _, _ in }

      axis(.vertical)
   }
}

public extension TitleBodySwitcherY {
   static func switcherWith(titleText: String, bodyText: String) -> Self {
      Self()
         .setAll { title, bodySwitcher in
            title.text(titleText)
            bodySwitcher.label.text(bodyText)
         }
   }
}
