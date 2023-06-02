//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public extension ViewSetterProtocol where View: PaddingLabel {
   @discardableResult func text(_ value: String) -> Self {
      let current = NSMutableAttributedString(attributedString: view.attributedText ?? NSMutableAttributedString())
      current.mutableString.setString(value)
      current.addAttribute(.paragraphStyle,
                           value: view.paragraphStyle,
                           range: .init(location: 0, length: current.length))
      
      view.attributedText = current
      view.sizeToFit()
      return self
   }
   
   @discardableResult func font(_ value: UIFont) -> Self {
      view.font = value
      return self
   }
   
   @discardableResult func textColor(_ value: UIColor) -> Self {
      view.textColor = value
      return self
   }
   
   @discardableResult func numberOfLines(_ value: Int) -> Self {
      view.numberOfLines = value
      return self
   }
   
   @discardableResult func alignment(_ value: NSTextAlignment) -> Self {
      view.paragraphStyle.alignment = value
      view.textAlignment = value
      return self
   }
   
   @discardableResult func attributedText(_ value: NSAttributedString) -> Self {
      view.attributedText = value
      return self
   }
   
   @discardableResult func padding(_ value: UIEdgeInsets) -> Self {
      view.padding = value
      return self
   }
   
   @discardableResult func padLeft(_ value: CGFloat) -> Self {
      view.padding.left = value
      return self
   }
   
   @discardableResult func padRight(_ value: CGFloat) -> Self {
      view.padding.right = value
      return self
   }
   
   @discardableResult func padTop(_ value: CGFloat) -> Self {
      view.padding.top = value
      return self
   }
   
   @discardableResult func padBottom(_ value: CGFloat) -> Self {
      view.padding.bottom = value
      return self
   }
   
   @discardableResult func cornerRadius(_ value: CGFloat) -> Self {
      view.layer.cornerRadius = value
      view.clipsToBounds = true
      return self
   }
   
   @discardableResult func lineBreakMode(_ value: NSLineBreakMode) -> Self {
      view.paragraphStyle.lineBreakMode = value
      return self
   }
   
   @discardableResult func lineSpacing(_ value: CGFloat) -> Self {
      let style = view.paragraphStyle
      style.lineSpacing = value
      let string = view.attributedText ?? NSAttributedString()
      let attrStr = NSMutableAttributedString(attributedString: string)
      attrStr.addAttribute(.paragraphStyle, value: style, range: .init())
      view.attributedText = attrStr
      view.paragraphStyle = style
      return self
   }
   
   @discardableResult func kerning(_ value: CGFloat) -> Self {
      let current = NSMutableAttributedString(attributedString: view.attributedText ?? NSMutableAttributedString())
      current.addAttribute(.kern, value: value, range: .init(location: 0, length: current.length))
      view.attributedText = current
      return self
   }
}
