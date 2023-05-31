//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public final class PaddingTextField: UITextField, Marginable, LoadableView {
   // padding extension
   public var padding: UIEdgeInsets = .init()
   public var placeholderColor: UIColor?
   public var isOnlyDigitsMode = false
   public var activityModel: UIViewModel?

   override public func textRect(forBounds bounds: CGRect) -> CGRect {
      bounds.inset(by: padding)
   }

   override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      bounds.inset(by: padding)
   }

   override public func editingRect(forBounds bounds: CGRect) -> CGRect {
      bounds.inset(by: padding)
   }

   public override func layoutSubviews() {
      super.layoutSubviews()

      for view in subviews {
         if let button = view as? UIButton {
            button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
         }
      }
   }
}
