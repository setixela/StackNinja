//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public extension ViewSetterProtocol where View: ScrollViewExtended {
   @discardableResult func viewModel(_ value: UIViewModel) -> Self {
      let uiView = value.uiView
      view.subviews.forEach { $0.removeFromSuperview() }
      view.addSubview(uiView)
      uiView.addAnchors
         .height(view.heightAnchor)
         .width(view.widthAnchor)
         .centerY(view.centerYAnchor)
      
      return self
   }
   
   @discardableResult func hideHorizontalScrollIndicator() -> Self {
      view.showsHorizontalScrollIndicator = false
      return self
   }
   
   @discardableResult func hideVerticalScrollIndicator() -> Self {
      view.showsVerticalScrollIndicator = false
      return self
   }
   
   @discardableResult func bounces(_ value: Bool) -> Self {
      view.bounces = value
      return self
   }
   
   @discardableResult func disableScroll() -> Self {
      view.isScrollEnabled = false
      return self
   }
   
   @discardableResult
   func scrollToBegin(_ value: Bool) -> Self {
      view.setContentOffset(.zero, animated: value)
      return self
   }
   
   @discardableResult
   func bounce(_ value: Bool) -> Self {
      view.bounces = value
      return self
   }
   
   @discardableResult
   func pagingEnabled(_ value: Bool) -> Self {
      view.isPagingEnabled = value
      return self
   }
   
   @discardableResult
   func safeAreaOffsetDisabled() -> Self {
      view.insetsLayoutMarginsFromSafeArea = false
      view.contentInsetAdjustmentBehavior = .never
      return self
   }
   
   @discardableResult
   func passThroughTouches(_ value: Bool = true) -> Self {
      view.isNeedPassThroughTuches = value
      return self
   }
}
