//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public enum ButtonState {
   case enabled(Bool)
   case selected(Bool)
   case title(String)
   case textColor(UIColor)
   case font(UIFont)
   case backColor(UIColor)
   case cornerRadius(CGFloat)
   case height(CGFloat)
   case width(CGFloat)
   case image(UIImage)
   case tint(UIColor)
   case vertical(Bool)
   case borderWidth(CGFloat)
   case borderColor(UIColor)
   case imageInset(UIEdgeInsets)
}

public extension ViewModelProtocol where Self: Stateable, View: ButtonExtended {
   func applyState(_ state: ButtonState) {
      switch state {
      case .enabled(let value):
         enabled(value)
      case .selected(let value):
         selected(value)
      case .title(let value):
         title(value)
      case .textColor(let value):
         textColor(value)
      case .backColor(let value):
         backColor(value)
      case .cornerRadius(let value):
         cornerRadius(value)
      case .height(let value):
         height(value)
      case .width(let value):
         width(value)
      case .font(let value):
         font(value)
      case .image(let value):
         image(value)
      case .tint(let value):
         tint(value)
      case .vertical(let value):
         vertical(value)
      case .borderColor(let value):
         borderColor(value)
      case .borderWidth(let value):
         borderWidth(value)
      case .imageInset(let value):
         imageInset(value)
      }
   }
}
