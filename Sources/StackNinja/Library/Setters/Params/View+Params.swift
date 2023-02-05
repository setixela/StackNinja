//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public enum ViewState {
   case backColor(UIColor)
   case cornerRadius(CGFloat)
   case borderWidth(CGFloat)
   case borderColor(UIColor)
   case size(CGSize)
   case height(CGFloat)
   case width(CGFloat)
   case hidden(Bool)
   case zPosition(CGFloat)
   case placing(CGPoint)
}

// MARK: -  Stateable extensions

public extension ViewModelProtocol where Self: Stateable {
   func applyState(_ state: ViewState) {
      switch state {
      case .backColor(let value):
         backColor(value)
      case .height(let value):
         height(value)
      case .cornerRadius(let value):
         cornerRadius(value)
      case .borderColor(let value):
         borderColor(value)
      case .borderWidth(let value):
         borderWidth(value)
      case .hidden(let value):
         hidden(value)
      case .size(let value):
         size(value)
      case .zPosition(let value):
         zPosition(value)
      case .placing(let value):
         placing(value)
      case .width(let value):
         width(value)
      }
   }
}
