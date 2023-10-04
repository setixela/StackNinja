//
//  StackView+Set.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public extension ViewSetterProtocol where View: StackViewExtended {
   @discardableResult func distribution(_ value: StackViewExtended.Distribution) -> Self {
      view.distribution = value
      return self
   }
   
   @discardableResult func axis(_ value: NSLayoutConstraint.Axis) -> Self {
      view.axis = value
      return self
   }
   
   @discardableResult func spacing(_ value: CGFloat) -> Self {
      view.spacing = value
      return self
   }
   
   @discardableResult func alignment(_ value: StackViewExtended.Alignment) -> Self {
      view.alignment = value
      return self
   }
   
   @discardableResult func padding(_ value: UIEdgeInsets) -> Self {
      view.layoutMargins = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func padHorizontal(_ value: CGFloat) -> Self {
      view.layoutMargins.left = value
      view.layoutMargins.right = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func padVertical(_ value: CGFloat) -> Self {
      view.layoutMargins.top = value
      view.layoutMargins.bottom = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func padLeft(_ value: CGFloat) -> Self {
      view.layoutMargins.left = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func padRight(_ value: CGFloat) -> Self {
      view.layoutMargins.right = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func padTop(_ value: CGFloat) -> Self {
      view.layoutMargins.top = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func padBottom(_ value: CGFloat) -> Self {
      view.layoutMargins.bottom = value
      view.isLayoutMarginsRelativeArrangement = true
      return self
   }
   
   @discardableResult func arrangedModels(_ value: [UIViewModel]) -> Self {
      view.arrangedSubviews.forEach {
         $0.removeFromSuperview()
      }
      value.forEach {
         let subview = $0.uiView
         view.addArrangedSubview(subview)
      }
      return self
   }
   
   @discardableResult func arrangedModels(_ value: UIViewModel...) -> Self {
      arrangedModels(value)
   }
   
   @discardableResult func addArrangedModel(_ value: UIViewModel) -> Self {
      let subview = value.uiView
      view.addArrangedSubview(subview)
      
      return self
   }

   @discardableResult func insertArrangedModel(_ value: UIViewModel, at index: Int) -> Self {
      let subview = value.uiView
      view.insertArrangedSubview(subview, at: index)
      return self
   }
   
   @discardableResult func addArrangedModels(_ value: [UIViewModel]) -> Self {
      value.forEach {
         let subview = $0.uiView
         view.addArrangedSubview(subview)
      }
      return self
   }
   
   @discardableResult func removeLastModel() -> Self {
      view.arrangedSubviews.last?.removeFromSuperview()
      return self
   }
   
   @discardableResult func backView(_ value: UIView, inset: UIEdgeInsets = .zero) -> Self {
      view.insertSubview(value, at: 0)
      view.backView = value
      value.addAnchors.fitToViewInsetted(view, inset)
      value.contentMode = .scaleAspectFill
      value.clipsToBounds = true
      value.layer.masksToBounds = false
      return self
   }
   
   @discardableResult func backImage(_ value: UIImage, contentMode: UIImageView.ContentMode = .scaleAspectFill) -> Self {
      let imageView = PaddingImageView(image: value)
      imageView.contentMode = contentMode
      backView(imageView)
      return self
   }
   
   @discardableResult func backViewModel(_ value: UIViewModel, inset: UIEdgeInsets = .zero) -> Self {
      let new = value.uiView
      backView(new, inset: inset)
      return self
   }
   
    @discardableResult func disableBottomRadius(_ value: CGFloat, matteColor: UIColor? = nil, isOnTop: Bool = false) -> Self {
      let backView = UIView()
      backView.backgroundColor = matteColor ?? view.backgroundColor
        if isOnTop {
            view.addSubview(backView)
        } else {
            view.insertSubview(backView, at: 0)
        }
      backView.addAnchors
         .constHeight(value)
         .width(view.widthAnchor)
         .bottom(view.bottomAnchor)
      return self
   }
}
