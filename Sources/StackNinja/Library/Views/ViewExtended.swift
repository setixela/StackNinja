//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

@objc public protocol TappableView {
   func startTapGestureRecognize(cancelTouch: Bool) -> Self
   @objc func didTap()
}

extension UIView: TappableView {
   @discardableResult
    public func startTapGestureRecognize(cancelTouch: Bool = false) -> Self {
      let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
      gesture.cancelsTouchesInView = cancelTouch
      addGestureRecognizer(gesture)
      isUserInteractionEnabled = true

      return self
   }

   @objc public func didTap() {
      (self as? any Tappable)?.send(\.didTap)
      animateTap(uiView: self)
   }
}

extension UIView: ButtonTapAnimator {}

open class PaddingView: UIView, Marginable {
   public var padding: UIEdgeInsets = .init()

   override public var alignmentRectInsets: UIEdgeInsets {
      .init(top: -padding.top,
            left: -padding.left,
            bottom: -padding.bottom,
            right: -padding.right)
   }
}

// MARK: - ViewExtended

open class ViewExtended: UIView, Tappable, LoadableView, ViewModelStorageView, Squircle {
   public var viewModel: UIViewModel?

   public var events: EventsStore = .init()
   public var activityModel: UIViewModel?

   override public func layoutSubviews() {
      super.layoutSubviews()

     send(\.didLayout)
   }
}
