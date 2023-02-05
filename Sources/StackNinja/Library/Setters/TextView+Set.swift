//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public extension ViewSetterProtocol where View: TextViewExtended {
   @discardableResult func text(_ value: String) -> Self {
      view.text = value
      return self
   }
   
   @discardableResult func placeholder(_ value: String) -> Self {
      view.placeholder = value
      view.textViewDidEndEditing(view)
      return self
   }
   
   @discardableResult func placeholderColor(_ value: UIColor) -> Self {
      view.placeHolderColor = value
      view.textViewDidEndEditing(view)
      return self
   }
   
   @discardableResult func font(_ value: UIFont) -> Self {
      view.font = value
      return self
   }
   
   @discardableResult func padding(_ value: UIEdgeInsets) -> Self {
      view.textContainerInset = value
      return self
   }
   
   @discardableResult func alignment(_ value: NSTextAlignment) -> Self {
      view.textAlignment = value
      return self
   }
   
   @discardableResult func textColor(_ value: UIColor) -> Self {
      view.baseTextColor = value
      return self
   }
   
   @discardableResult func keyboardType(_ value: UIKeyboardType) -> Self {
      view.keyboardType = value
      return self
   }
   
   @discardableResult func disableAutocorrection() -> Self {
      view.autocorrectionType = .no
      return self
   }
}
