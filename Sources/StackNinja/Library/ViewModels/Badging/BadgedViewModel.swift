//
//  BadgedViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 10.08.2022.
//

import ReactiveWorks
import UIKit

// MARK: - New

public enum TopBadgerState {
   case badgeState(ViewState)
   case badgeLabelState(LabelState)
   case badgeLabelStates([LabelState])
   case presentBadge(String)
   case hideBadge
}

public final class TopBadger<VM: VMPS>: StackNinja<SComboMD<WrappedY<LabelModel>, VM>> {
   public var mainModel: VM { models.down }

   public required init() {
      super.init()

      setAll { topBadge, _ in
         topBadge
            .padding(.verticalShift(-7.5))
            .padLeft(16)
            .zPosition(1000)
            .alignment(.leading)
      }
   }
}

extension TopBadger: Stateable2 {
   public func applyState(_ state: TopBadgerState) {
      switch state {
      case let .badgeState(value):
         models.main.subModel.set(value)
      case let .badgeLabelStates(value):
         models.main.subModel.set(value)
      case let .presentBadge(value):
         models.main.subModel.text(value)
      case .hideBadge:
         models.main.subModel.text("")
      case let .badgeLabelState(value):
         models.main.subModel.set(value)
      }
   }
}
