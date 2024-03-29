//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import Anchorage
import UIKit

public extension ViewSetterProtocol {
   @discardableResult func backColor(_ value: UIColor) -> Self {
      view.backgroundColor = value
      return self
   }

   @discardableResult func cornerRadius(_ value: CGFloat) -> Self {
      view.layer.cornerRadius = value
      return self
   }

   @discardableResult func cornerCurve(_ value: CALayerCornerCurve) -> Self {
      view.layer.cornerCurve = value
      return self
   }
   
   @discardableResult func maskedCorners(_ value: CACornerMask) -> Self {
      view.layer.maskedCorners = value
      return self
   }

   @discardableResult func borderWidth(_ value: CGFloat) -> Self {
      view.layer.borderWidth = value
      return self
   }

   @discardableResult func borderColor(_ value: UIColor) -> Self {
      view.layer.borderColor = value.cgColor
      return self
   }

   @discardableResult func size(_ value: CGSize) -> Self {
      width(value.width)
      height(value.height)
      return self
   }

   @discardableResult func circleWithDiameter(_ value: CGFloat) -> Self {
      size(.init(width: value, height: value))
      cornerRadius(value / 2)
      return self
   }

   @discardableResult func height(_ value: CGFloat) -> Self {
      view.addAnchors.constHeight(value)
      return self
   }

   @discardableResult func height(_ value: CGFloat, priority: UILayoutPriority = .defaultHigh) -> Self {
      view.addAnchors.constHeight(value).priority(priority)
      return self
   }

   @discardableResult func width(_ value: CGFloat) -> Self {
      view.addAnchors.constWidth(value)
      return self
   }

   @discardableResult func width(_ value: CGFloat, priority: UILayoutPriority) -> Self {
      view.addAnchors.constWidth(value).priority(priority)
      return self
   }

   @discardableResult func maxHeight(_ value: CGFloat) -> Self {
      view.addAnchors.maxHeight(value)
      return self
   }

   @discardableResult func maxWidth(_ value: CGFloat) -> Self {
      view.addAnchors.maxWidth(value)
      return self
   }

   @discardableResult func minHeight(_ value: CGFloat) -> Self {
      view.addAnchors.minHeight(value)
      return self
   }

   @discardableResult func minWidth(_ value: CGFloat) -> Self {
      view.addAnchors.minWidth(value)
      return self
   }

   @discardableResult func sizeAspect(_ value: CGSize) -> Self {
      widthAspect(value.width)
      heightAspect(value.height)
      return self
   }

   @discardableResult func heightAspect(_ value: CGFloat) -> Self {
      view.addAnchors.constHeight(value * LayoutConfig.sizeAspectCoeficient)
      return self
   }

   @discardableResult func widthAspect(_ value: CGFloat) -> Self {
      view.addAnchors.constWidth(value * LayoutConfig.sizeAspectCoeficient)
      return self
   }

   @discardableResult func fillingWidth() -> Self {
      width(CGFloat(Int.max), priority: .defaultLow)
      return self
   }

   @discardableResult func fillingHeight() -> Self {
      height(CGFloat(Int.max), priority: .defaultLow)
      return self
   }

   @discardableResult func hidden(_ value: Bool, isAnimated: Bool = false) -> Self {
      guard isAnimated else {
         view.isHidden = value
         return self
      }

      UIView.animate(withDuration: 0.25) {
         self.view.isHidden = value
      } completion: { _ in
         self.view.isHidden = value
      }

      return self
   }

   @discardableResult func hiddenAnimated(_ isHidden: Bool, duration: CGFloat) -> Self {
      UIView.animate(withDuration: duration) {
         self.view.isHidden = isHidden
      } completion: { _ in
         self.view.isHidden = isHidden
      }

      return self
   }

   @discardableResult func alpha(_ value: CGFloat) -> Self {
      view.alpha = value
      return self
   }

   @discardableResult func zPosition(_ value: CGFloat) -> Self {
      view.layer.masksToBounds = false
      view.clipsToBounds = false
      view.layer.zPosition = value
      view.setNeedsLayout()
      return self
   }

   @discardableResult func placing(_ value: CGPoint) -> Self {
      view.center = value
      return self
   }

   @discardableResult func shadow(_ value: Shadow) -> Self {
      view.layer.shadowColor = value.color.cgColor
      view.layer.shadowOffset = .init(width: value.offset.x, height: value.offset.y)
      view.layer.shadowRadius = value.radius
      view.layer.shadowOpacity = Float(value.opacity)
      return self
   }

   @discardableResult func shadowOpacity(_ value: CGFloat) -> Self {
      view.layer.shadowOpacity = Float(value)
      return self
   }

    @discardableResult func addModel(
        _ value: UIViewModel,
        setup: ((Anchors, UIView) -> Void)? = { $0.fitToView($1) }
    ) -> Self
    {
        let subview = value.uiView
        view.addSubview(subview)
        setup?(subview.addAnchors, view)
        return self
   }

   @discardableResult func subviewModel(_ value: UIViewModel) -> Self {
      let subview = value.uiView
      view.addSubview(subview)
      subview.addAnchors.fitToView(view)

      return self
   }

   @discardableResult func subviewModels(_ value: [UIViewModel]) -> Self {
      value.forEach {
         let subview = $0.uiView
         view.addSubview(subview)
         subview.addAnchors.fitToView(view)
      }
      return self
   }

   @discardableResult func contentMode(_ value: UIView.ContentMode) -> Self {
      view.contentMode = value
      return self
   }

   @discardableResult func safeAreaOffsetDisabled() -> Self {
      view.insetsLayoutMarginsFromSafeArea = false
      return self
   }

   @discardableResult func clipsToBound(_ value: Bool) -> Self {
      view.clipsToBounds = value
      return self
   }

   @discardableResult func maskToBounds(_ value: Bool) -> Self {
      view.layer.masksToBounds = value
      return self
   }

   @discardableResult func removeAllConstraints() -> Self {
      view.removeAllConstraints()
      return self
   }

   @discardableResult func userInterractionEnabled(_ value: Bool) -> Self {
      view.isUserInteractionEnabled = value
      return self
   }

   @discardableResult func removeTapGestures() -> Self {
      for gesture in view.gestureRecognizers ?? [] {
         print(gesture)
         if gesture is UITapGestureRecognizer {
            view.removeGestureRecognizer(gesture)
         }
      }
      return self
   }

   @discardableResult func cancelToucherForAllGestures(_ value: Bool) -> Self {
      for gesture in view.gestureRecognizers ?? [] {
         gesture.cancelsTouchesInView = value
      }
      return self
   }

   @discardableResult func contentScale(_ value: CGFloat) -> Self {
      view.contentScaleFactor = value
      return self
   }

   @discardableResult
   func startTapGestureRecognize(cancelTouch: Bool = false) -> Self where Self: Tappable, Self.View: Tappable {
      view.startTapGestureRecognize(cancelTouch: cancelTouch)
      view.on(\.didTap, self) {
         $0.send(\.didTap)
      }
      return self
   }

   @discardableResult
   func gradient(_ value: Gradient, size: CGSize) -> Self {
      let view: UIView = view
      let gradientLayer = CAGradientLayer()
      gradientLayer.cornerRadius = view.layer.cornerRadius
      gradientLayer.masksToBounds = true
      gradientLayer.frame = .init(x: 0, y: 0, width: size.width, height: size.height)
      gradientLayer.colors = value.colors.map(\.cgColor)
      gradientLayer.startPoint = value.startPoint
      gradientLayer.endPoint = value.endPoint
      view.layer.insertSublayer(gradientLayer, at: 0)

      return self
   }

   @discardableResult
   func rotate(_ degrees: CGFloat) -> Self {
      view.transform = CGAffineTransform(rotationAngle: degrees * .pi / 180)
      return self
   }
}

public struct Gradient {
   public let colors: [UIColor]
   public let startPoint: CGPoint
   public let endPoint: CGPoint

   public init(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
      self.colors = colors
      self.startPoint = startPoint
      self.endPoint = endPoint
   }
}
