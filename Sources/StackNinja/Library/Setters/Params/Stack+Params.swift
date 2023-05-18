//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public enum StackState {
   case distribution(StackViewExtended.Distribution)
   case axis(NSLayoutConstraint.Axis)
   case spacing(CGFloat)
   case alignment(StackViewExtended.Alignment)
   case padding(UIEdgeInsets)
   case backColor(UIColor)
   case cornerRadius(CGFloat)
   case cornerCurve(CALayerCornerCurve)
   case borderWidth(CGFloat)
   case borderColor(UIColor)
   case height(CGFloat)
   case arrangedModels([UIViewModel])
   case hidden(Bool, isAnimated: Bool = false)
   case backView(UIView, inset: UIEdgeInsets = .zero)
   case backImage(UIImage)
   case backViewModel(UIViewModel, inset: UIEdgeInsets = .zero)
   case shadow(Shadow)
}

public extension ViewModelProtocol where Self: Stateable, View: StackViewExtended {
   func applyState(_ state: StackState) {
      switch state {
      // Stack View
      case let .distribution(value):
         distribution(value)
      case let .axis(value):
         axis(value)
      case let .spacing(value):
         spacing(value)
      case let .alignment(value):
         alignment(value)
      case let .padding(value):
         padding(value)
      case let .arrangedModels(value):
         arrangedModels(value)
      case let .backView(value, value2):
         backView(value, inset: value2)
      case let .backImage(image):
         backImage(image)

      // View
      case let .backColor(value):
         backColor(value)
      case let .height(value):
         height(value)
      case let .cornerRadius(value):
         cornerRadius(value)
      case .cornerCurve(let value):
         cornerCurve(value)
      case let .borderColor(value):
         borderColor(value)
      case let .borderWidth(value):
         borderWidth(value)
      case let .hidden(value, animated):
         hidden(value, isAnimated: animated)
      case let .backViewModel(value, inset):
         backViewModel(value, inset: inset)
      case let .shadow(value):
         shadow(value)
      }
   }
}
