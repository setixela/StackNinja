//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public enum LabelState {
   case text(String)
   case font(UIFont)
   case textColor(UIColor)
   case numberOfLines(Int)
   case alignment(NSTextAlignment)
   case attributedText(NSAttributedString)
   // Padding
   case padding(UIEdgeInsets)
   case padLeft(CGFloat)
   case padRight(CGFloat)
   case padUp(CGFloat)
   case padBottom(CGFloat)
}

public extension ViewModelProtocol where Self: Stateable, View: PaddingLabel {
   func applyState(_ state: LabelState) {
      switch state {
      case .text(let value):
         text(value)
      case .font(let value):
         font(value)
      case .textColor(let value):
         textColor(value)
      case .numberOfLines(let value):
         numberOfLines(value)
      case .alignment(let value):
         alignment(value)
      case .attributedText(let value):
         attributedText(value)
      case .padding(let value):
         padding(value)
      case .padLeft(let value):
         padLeft(value)
      case .padRight(let value):
         padRight(value)
      case .padUp(let value):
         padTop(value)
      case .padBottom(let value):
         padBottom(value)
      }
   }
}
