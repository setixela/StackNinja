//
//  ScrollViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 23.11.2022.
//

import ReactiveWorks
import UIKit

open class ScrollViewModel: BaseViewModel<ScrollViewExtended>, UIScrollViewDelegate, Stateable2 {
   public typealias State = ViewState
   public typealias State2 = ScrollState

   private lazy var zoomingTap: UITapGestureRecognizer = {
      let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
      zoomingTap.numberOfTapsRequired = 2
      return zoomingTap
   }()

   override open func start() {
      super.start()
   }

   public func viewForZooming(in _: UIScrollView) -> UIView? {
      let zoomView = view.subviews.first
      return zoomView
   }

   @objc private func handleZoomingTap(sender: UITapGestureRecognizer) {
      let location = sender.location(in: sender.view)
      zoom(point: location, animated: true)
   }

   private func zoom(point: CGPoint, animated: Bool) {
      let currentScale = view.zoomScale
      let minScale = view.minimumZoomScale
      let maxScale = view.maximumZoomScale

      if minScale == maxScale, minScale > 1 {
         return
      }

      let toScale = maxScale
      let finalScale = (currentScale == minScale) ? toScale : minScale
      let zoomRect = zoomRect(scale: finalScale, center: point)
      view.zoom(to: zoomRect, animated: animated)
   }

   private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
      var zoomRect = CGRect.zero
      let bounds = view.bounds

      zoomRect.size.width = bounds.size.width / scale
      zoomRect.size.height = bounds.size.height / scale

      zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
      zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
      return zoomRect
   }

   private func configurateFor(size: CGSize) {
      view.contentSize = size

      view.zoomScale = view.minimumZoomScale

      guard let imageZoomView = viewForZooming(in: view) else { return }

      imageZoomView.addGestureRecognizer(zoomingTap)
      imageZoomView.isUserInteractionEnabled = true
   }
}

public extension ScrollViewModel {
   @discardableResult func zooming(min: CGFloat, max: CGFloat) -> Self {
      view.delegate = self
      view.maximumZoomScale = max
      view.minimumZoomScale = min
      return self
   }

   @discardableResult func doubleTapForZooming() -> Self {
      view.delegate = self

      guard let subview = viewForZooming(in: view) else {
         return self
      }

      guard let image = (subview as? UIImageView)?.image else {
         configurateFor(size: subview.bounds.size)
         return self
      }
      let size = image.size

      configurateFor(size: size)

      return self
   }
}
