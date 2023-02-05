//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public extension ViewSetterProtocol where View: ButtonExtended {
   @discardableResult func enabled(_ value: Bool) -> Self {
      view.isEnabled = value
      return self
   }
   
   @discardableResult func selected(_ value: Bool) -> Self {
      view.isSelected = value
      return self
   }
   
   @discardableResult func title(_ value: String) -> Self {
      view.setTitle(value, for: .normal)
      return self
   }
   
   @discardableResult func textColor(_ value: UIColor) -> Self {
      view.setTitleColor(value, for: .normal)
      return self
   }
   
   @discardableResult func font(_ value: UIFont) -> Self {
      view.titleLabel?.font = value
      return self
   }
   
   @discardableResult func image(_ value: UIImage?, color: UIColor? = nil) -> Self {
      let image = color == nil ? value : value?.withTintColor(color!)
      view.setImage(image, for: .normal)
      return self
   }
   
   @discardableResult func backImage(_ value: UIImage?) -> Self {
      view.setBackgroundImage(value, for: .normal)
      return self
   }
   
   @discardableResult func imageContentMode(_ value: UIView.ContentMode) -> Self {
      view.imageView?.contentMode = value
      return self
   }
   
   @discardableResult func tint(_ value: UIColor) -> Self {
      view.tintColor = value
      view.setTitleColor(value, for: .normal)
      view.imageView?.tintColor = value
      return self
   }
   
   @discardableResult func vertical(_ value: Bool) -> Self {
      view.isVertical = value
      return self
   }
   
   @discardableResult func imageInset(_ value: UIEdgeInsets) -> Self {
      view.imageEdgeInsets = value
      return self
   }
   
   @discardableResult func padding(_ value: UIEdgeInsets) -> Self {
      view.contentEdgeInsets = value
      return self
   }
   
   @discardableResult func backImageUrl(_ value: String?) -> Self {
      view.loadImage(value) { [weak view] in
         guard let image = $0 else { return }
         
         view?.setBackgroundImage(image, for: .normal)
      }
      
      return self
   }
   
   @discardableResult func cornerRadius(_ value: CGFloat) -> Self {
      view.layer.cornerRadius = value
      view.clipsToBounds = true
      return self
   }
   
   @discardableResult func shadow(_ value: Shadow) -> Self {
      view.layer.shadowColor = value.color.cgColor
      view.layer.shadowOffset = .init(width: value.offset.x, height: value.offset.y)
      view.layer.shadowRadius = value.radius
      view.layer.shadowOpacity = Float(value.opacity)
      view.clipsToBounds = false
      return self
   }
}
