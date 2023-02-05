//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public enum TextFieldState {
   case text(String)
   case placeholder(String)
   case placeholderColor(UIColor)
   case backColor(UIColor)
   case textColor(UIColor)
   case font(UIFont)
   case clearButtonMode(UITextField.ViewMode)
   case padding(UIEdgeInsets)
   case height(CGFloat)
   case widht(CGFloat)
   case cornerRadius(CGFloat)
   case borderWidth(CGFloat)
   case borderColor(UIColor)
   case size(CGSize)
   case zPosition(CGFloat)
   case placing(CGPoint)
}

public extension ViewModelProtocol where Self: Stateable, View: PaddingTextField {
   func applyState(_ state: TextFieldState) {
      switch state {
      case let .text(value):
         text(value)
      case let .placeholder(value):
         placeholder(value)
      case let .backColor(value):
         backColor(value)
      case let .textColor(value):
         textColor(value)
      case let .font(value):
         font(value)
      case let .clearButtonMode(value):
         clearButtonMode(value)
      case let .padding(value):
         padding(value)
      case let .height(value):
         height(value)
      case let .widht(value):
         width(value)
      case let .cornerRadius(value):
         cornerRadius(value)
      case let .borderColor(value):
         borderColor(value)
      case let .borderWidth(value):
         borderWidth(value)
      case let .size(value):
         size(value)
      case let .zPosition(value):
         zPosition(value)
      case let .placing(value):
         placing(value)
      case let .placeholderColor(value):
         placeholderColor(value)
      }
   }
}

public extension ViewModelProtocol where Self: Stateable, View: PaddingTextField {
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
