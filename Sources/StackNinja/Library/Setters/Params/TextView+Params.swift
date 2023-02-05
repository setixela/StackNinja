//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public enum TextViewState {
   case text(String)
   case font(UIFont)
   case padding(UIEdgeInsets)
   case height(CGFloat)
   case width(CGFloat)
}

public extension ViewModelProtocol where Self: Stateable, View: TextViewExtended {
   func applyState(_ state: TextViewState) {
      switch state {
      case .text(let string):
         text(string)
      case .font(let value):
         font(value)
      case .padding(let value):
         padding(value)
      case .height(let value):
         height(value)
      case .width(let value):
         width(value)
      }
   }
}

public extension ViewModelProtocol where Self: Stateable, View: TextViewExtended {
   func applyState(_ state: LabelState) {
      switch state {
      case .text(let value):
         text(value)
      case .font(let value):
         font(value)
      case .textColor(let value):
         textColor(value)
      case .numberOfLines:
         break
      case .alignment(let value):
         alignment(value)
      case .padding(let value):
         padding(value)
      case .padLeft:
         break
      case .padRight:
         break
      case .padUp:
         break
      case .padBottom:
         break
      case .attributedText(_):
         break
      }
   }
}

