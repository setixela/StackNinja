//
//  SpacerPresenter.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 21.08.2022.
//

import CoreGraphics

public struct SpacerItem {
   public let size: CGFloat
   
   public init(_ size: CGFloat) {
      self.size = size
   }
}

extension SpacerItem: DisableSelectModifier {}

// MARK: - Presenter

public enum SpacerPresenter {
   public static var presenter: CellPresenterWork<SpacerItem, Spacer> {
      .init { work in
         let item = work.unsafeInput.item
         work.success(result: Spacer(item.size))
      }
   }
}
