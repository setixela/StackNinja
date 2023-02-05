//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 04.02.2023.
//

import UIKit

public final class SpacerView: UIView {
   public convenience init(_ size: CGFloat = .zero) {
      self.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
      if size != 0 {
         addAnchors
            .constWidth(size)
            .constHeight(size)
      }
      backgroundColor = .none
      isAccessibilityElement = false
   }

   override init(frame: CGRect) {
      super.init(frame: frame)
   }

   public convenience init() {
      self.init(.zero)
   }

   @available(*, unavailable)
   required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
