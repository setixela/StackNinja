//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 20.03.2023.
//

import UIKit
import ReactiveWorks

public protocol Squircle: UIView, Eventable where Events == ViewEvents {
   func squircle(_ value: CGFloat, convexity: CGFloat)
   func topSquircle(_ value: CGFloat, convexity: CGFloat)
   func bottomSquircle(_ value: CGFloat, convexity: CGFloat)
}

public extension Squircle {
   func squircle(_ value: CGFloat, convexity: CGFloat = 0) {

      let fun = { [weak self] in
         guard let self else { return }

         let maskLayer = CAShapeLayer()
         maskLayer.path = UIBezierPath
            .superellipse(in: self.bounds.size, cornerRadius: value, convexity: convexity)
            .cgPath
         self.layer.mask = maskLayer
      }

      on(\.didLayout, self) {
         if $0.layer.mask != nil {
            fun()
         }
      }

      fun()
   }

   func topSquircle(_ value: CGFloat, convexity: CGFloat = 0) {

      let fun = { [weak self] in
         guard let self else { return }

         let maskLayer = CAShapeLayer()
         maskLayer.path = UIBezierPath
            .topSuperellipse(in: self.bounds.size, cornerRadius: value, convexity: convexity)
            .cgPath
         self.layer.mask = maskLayer
      }

      on(\.didLayout, self) {
         if $0.layer.mask != nil {
            fun()
         }
      }

      fun()
   }

   func bottomSquircle(_ value: CGFloat, convexity: CGFloat = 0) {

      let fun = { [weak self] in
         guard let self else { return }

         let maskLayer = CAShapeLayer()
         maskLayer.path = UIBezierPath
            .bottomSuperellipse(in: self.bounds.size, cornerRadius: value, convexity: convexity)
            .cgPath
         self.layer.mask = maskLayer
      }

      on(\.didLayout, self) {
         if $0.layer.mask != nil {
            fun()
         }
      }

      fun()
   }
}

public extension UIBezierPath {
   static func superellipse(in size: CGSize, cornerRadius: CGFloat, convexity: CGFloat = 0) -> UIBezierPath {
      let rect = CGRect(origin: .zero, size: size)
      let minSide = min(rect.width, rect.height)
      let radius = min(cornerRadius, minSide / 2)

      let topLeft =     CGPoint(x: rect.minX + radius * convexity, y: rect.minY + radius * convexity)
      let topRight =    CGPoint(x: rect.maxX - radius * convexity, y: rect.minY + radius * convexity)
      let bottomLeft =  CGPoint(x: rect.minX + radius * convexity, y: rect.maxY - radius * convexity)
      let bottomRight = CGPoint(x: rect.maxX - radius * convexity, y: rect.maxY - radius * convexity)

      let p0 = CGPoint(x: rect.minX + radius, y: rect.minY)
      let p1 = CGPoint(x: rect.maxX - radius, y: rect.minY)

      let p2 = CGPoint(x: rect.maxX, y: rect.minY + radius)
      let p3 = CGPoint(x: rect.maxX, y: rect.maxY - radius)

      let p4 = CGPoint(x: rect.maxX - radius, y: rect.maxY)
      let p5 = CGPoint(x: rect.minX + radius, y: rect.maxY)

      let p6 = CGPoint(x: rect.minX, y: rect.maxY - radius)
      let p7 = CGPoint(x: rect.minX, y: rect.minY + radius)

      let path = UIBezierPath()
      path.move(to: p0)
      path.addLine(to: p1)
      path.addCurve(to: p2, controlPoint1: topRight, controlPoint2: topRight)
      path.addLine(to: p3)
      path.addCurve(to: p4, controlPoint1: bottomRight, controlPoint2: bottomRight)
      path.addLine(to: p5)
      path.addCurve(to: p6, controlPoint1: bottomLeft, controlPoint2: bottomLeft)
      path.addLine(to: p7)
      path.addCurve(to: p0, controlPoint1: topLeft, controlPoint2: topLeft)

      return path
   }

   // only top rounded corners, not bottom corners
   static func topSuperellipse(in size: CGSize, cornerRadius: CGFloat, convexity: CGFloat = 0) -> UIBezierPath {
      let rect = CGRect(origin: .zero, size: size)
      let minSide = min(rect.width, rect.height)
      let radius = min(cornerRadius, minSide / 2)

      let topLeft =     CGPoint(x: rect.minX + radius * convexity, y: rect.minY + radius * convexity)
      let topRight =    CGPoint(x: rect.maxX - radius * convexity, y: rect.minY + radius * convexity)
      let bottomLeft =  CGPoint(x: rect.minX, y: rect.maxY)
      let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)

      let p0 = CGPoint(x: rect.minX + radius, y: rect.minY)
      let p1 = CGPoint(x: rect.maxX - radius, y: rect.minY)

      let p2 = CGPoint(x: rect.maxX, y: rect.minY + radius)
      let p3 = CGPoint(x: rect.maxX, y: rect.maxY - radius)

      let p7 = CGPoint(x: rect.minX, y: rect.minY + radius)

      let path = UIBezierPath()
      path.move(to: p0)
      path.addLine(to: p1)
      path.addCurve(to: p2, controlPoint1: topRight, controlPoint2: topRight)
      path.addLine(to: p3)
      path.addLine(to: bottomRight)
      path.addLine(to: bottomLeft)
      path.addLine(to: p7)
      path.addCurve(to: p0, controlPoint1: topLeft, controlPoint2: topLeft)

      return path
   }

   // only bottom rounded corners, not bottom corners
   static func bottomSuperellipse(in size: CGSize, cornerRadius: CGFloat, convexity: CGFloat = 0) -> UIBezierPath {
      let rect = CGRect(origin: .zero, size: size)
      let minSide = min(rect.width, rect.height)
      let radius = min(cornerRadius, minSide / 2)

      let topLeft =     CGPoint(x: rect.minX, y: rect.minY)
      let topRight =    CGPoint(x: rect.maxX, y: rect.minY)
      let bottomLeft =  CGPoint(x: rect.minX + radius * convexity, y: rect.maxY - radius * convexity)
      let bottomRight = CGPoint(x: rect.maxX - radius * convexity, y: rect.maxY - radius * convexity)

      let p3 = CGPoint(x: rect.maxX, y: rect.maxY - radius)

      let p4 = CGPoint(x: rect.maxX - radius, y: rect.maxY)
      let p5 = CGPoint(x: rect.minX + radius, y: rect.maxY)

      let p6 = CGPoint(x: rect.minX, y: rect.maxY - radius)
      let p7 = CGPoint(x: rect.minX, y: rect.minY + radius)

      let path = UIBezierPath()
      path.move(to: topLeft)
      path.addLine(to: topRight)
      path.addLine(to: p3)
      path.addCurve(to: p4, controlPoint1: bottomRight, controlPoint2: bottomRight)
      path.addLine(to: p5)
      path.addCurve(to: p6, controlPoint1: bottomLeft, controlPoint2: bottomLeft)
      path.addLine(to: p7)
      path.addLine(to: topLeft)

      return path
   }
}
