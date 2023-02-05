//
//  Shadow.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 25.08.2022.
//

import UIKit

public struct Shadow {
   public let radius: CGFloat
   public let offset: CGPoint
   public let color: UIColor
   public let opacity: CGFloat

   public init(
      radius: CGFloat = 1,
      offset: CGPoint = .zero,
      color: UIColor = .label,
      opacity: CGFloat = 1
   ) {
      self.radius = radius
      self.offset = offset
      self.color = color
      self.opacity = opacity
   }

   public static var noShadow: Shadow {
      Shadow(radius: 0, offset: .zero, color: .clear, opacity: 0)
   }
}
