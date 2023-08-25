//
//  UIEdgeInsets+Padding.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 14.08.2022.
//

import UIKit

public extension UIEdgeInsets {
   static func left(_ offset: CGFloat) -> UIEdgeInsets {
      UIEdgeInsets(top: 0, left: offset, bottom: 0, right: 0)
   }

   static func top(_ offset: CGFloat) -> UIEdgeInsets {
      UIEdgeInsets(top: offset, left: 0, bottom: 0, right: 0)
   }

   static func right(_ offset: CGFloat) -> UIEdgeInsets {
      UIEdgeInsets(top: 0, left: 0, bottom: 0, right: offset)
   }

   static func bottom(_ offset: CGFloat) -> UIEdgeInsets {
      UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
   }

   static func verticalShift(_ offset: CGFloat) -> UIEdgeInsets {
      .init(top: -offset, left: 0, bottom: offset, right: 0)
   }

   static func horizontalShift(_ offset: CGFloat) -> UIEdgeInsets {
      UIEdgeInsets(top: 0, left: offset, bottom: 0, right: -offset)
   }

   static func outline(_ width: CGFloat) -> UIEdgeInsets {
      .init(top: width, left: width, bottom: width, right: width)
   }

   static func verticalOffset(_ offset: CGFloat) -> UIEdgeInsets {
      .init(top: offset, left: 0, bottom: offset, right: 0)
   }

   static func horizontalOffset(_ offset: CGFloat) -> UIEdgeInsets {
      .init(top: 0, left: offset, bottom: 0, right: offset)
   }

   static func shift(_ shift: CGPoint) -> UIEdgeInsets {
      .init(top: -shift.y, left: shift.x, bottom: shift.y, right: -shift.x)
   }

}
