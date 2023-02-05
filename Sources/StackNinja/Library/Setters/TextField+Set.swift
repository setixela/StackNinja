//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public extension ViewSetterProtocol where View: PaddingTextField {
   @discardableResult func text(_ value: String) -> Self {
      view.text = value
      return self
   }
   
   @discardableResult func placeholder(_ value: String) -> Self {
      if let color = view.placeholderColor {
         view.attributedPlaceholder = NSAttributedString(
            string: value,
            attributes: [NSAttributedString.Key.foregroundColor: color]
         )
      } else {
         view.placeholder = value
      }
      return self
   }
   
   @discardableResult func placeholderColor(_ value: UIColor) -> Self {
      let placeholder = view.placeholder.string
      view.placeholderColor = value
      view.attributedPlaceholder = NSAttributedString(
         string: placeholder,
         attributes: [NSAttributedString.Key.foregroundColor: value]
      )
      return self
   }
   
   @discardableResult func font(_ value: UIFont) -> Self {
      view.font = value
      return self
   }
   
   @discardableResult func padding(_ value: UIEdgeInsets) -> Self {
      view.padding = value
      return self
   }
   
   @discardableResult func clearButtonMode(_ value: UITextField.ViewMode) -> Self {
      view.clearButtonMode = value
      return self
   }
   
   @discardableResult func alignment(_ value: NSTextAlignment) -> Self {
      view.textAlignment = value
      return self
   }
   
   @discardableResult func textColor(_ value: UIColor) -> Self {
      view.textColor = value
      return self
   }
   
   @discardableResult func keyboardType(_ value: UIKeyboardType) -> Self {
      view.keyboardType = value
      return self
   }
   
   @discardableResult func onlyDigitsMode() -> Self {
      view.isOnlyDigitsMode = true
      return self
   }
   
   @discardableResult func disableAutocorrection() -> Self {
      view.autocorrectionType = .no
      return self
   }
}
