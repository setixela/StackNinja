//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public enum ImageViewState {
   case image(UIImage)
   case contentMode(UIView.ContentMode)
   case padding(UIEdgeInsets)
   case imageTintColor(UIColor)
   case textImage(String, UIColor)
}

public extension ViewModelProtocol where Self: Stateable, View: PaddingImageView {
   func applyState(_ state: ImageViewState) {
      switch state {
      case .image(let value):
         image(value)
      case .contentMode(let value):
         contentMode(value)
      case .padding(let value):
         padding(value)
      case .imageTintColor(let value):
         imageTintColor(value)
      case .textImage(let value, let backColor):
         textImage(value, backColor)
      }
   }
}
