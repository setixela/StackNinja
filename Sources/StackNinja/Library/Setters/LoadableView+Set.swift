//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import Anchorage
import UIKit

public extension ViewSetterProtocol where View: LoadableView {
   
   @discardableResult func presentActivityModel(_ value: UIViewModel, centerShift: CGPoint = .zero) -> Self {
      view.activityModel?.uiView.removeFromSuperview()
      
      value.uiView.addToSuperview(view)
         .centerY(view.centerYAnchor, centerShift.y)
         .centerX(view.centerXAnchor, centerShift.x)
      view.activityModel = value
      return self
   }
   
   @discardableResult func hideActivityModel() -> Self {
      view.activityModel?.uiView.removeFromSuperview()
      view.activityModel = nil
      return self
   }
}
