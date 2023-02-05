//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public protocol ButtonTapAnimator {}

public extension ButtonTapAnimator {
   func animateTap(uiView: UIView) {
      let frame = uiView.frame
      uiView.frame = uiView.frame.inset(by: .init(top: 3, left: 2, bottom: -2, right: 3))
      UIView.animate(withDuration: 0.3) {
         uiView.frame = frame
      }
   }

   func animateTapWithShadow(uiView: UIView) {
      let frame = uiView.frame
      uiView.frame = uiView.frame.inset(by: .init(top: 5, left: 2, bottom: -3, right: 3))
      let layer = uiView.layer
      let radius = layer.shadowRadius
      let color = layer.shadowColor
      let opacity = layer.shadowOpacity
      let masksToBounds = layer.masksToBounds
      let clipsToBounds = uiView.clipsToBounds
      layer.masksToBounds = false
      uiView.clipsToBounds = false
      layer.shadowOpacity = 0.15
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowRadius = 5
      UIView.animate(withDuration: 0.3) {
         uiView.frame = frame
         layer.shadowOpacity = opacity
         layer.shadowColor = color
         layer.shadowRadius = 100
         uiView.setNeedsDisplay()
      } completion: { _ in
         layer.shadowRadius = radius
         layer.masksToBounds = masksToBounds
         uiView.clipsToBounds = clipsToBounds
      }
   }
}
