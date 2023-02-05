//
//  Spacer.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 21.06.2022.
//

import Anchorage
import ReactiveWorks
import UIKit

public final class Spacer: BaseViewModel<SpacerView>, Stateable {
   public typealias State = ViewState

   public convenience init(_ size: CGFloat = .zero) {
      self.init()

      if size != 0 {
         view.addAnchors
            .constWidth(size)
            .constHeight(size)
      }
   }

   public convenience init(maxSize: CGFloat) {
      self.init()

      if maxSize != 0 {
         view.addAnchors
            .maxWidth(maxSize)
            .maxHeight(maxSize)
      }
   }
}
