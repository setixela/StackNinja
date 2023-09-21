//
//  ScrollViewModels.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 22.08.2022.
//

import ReactiveWorks
import UIKit

public enum ScrollState {
   case arrangedModels([UIViewModel])
   case addArrangedModels([UIViewModel])
   case spacing(CGFloat)
   case scrollToTopAnimated(Bool)
   case hideHorizontalScrollIndicator
   case hideVerticalScrollIndicator
   case padding(UIEdgeInsets)
   case contentInset(UIEdgeInsets)
   case bounce(Bool)
}

open class BaseScrollStacked: BaseViewModel<ScrollViewExtended>, Eventable, Stateable2 {
   public var events = EventsStore()

   public typealias Events = ScrollEvents
   public typealias State = ViewState
   public typealias State2 = ScrollState

   public lazy var stack = StackModel()

   override public func start() {
      view.addSubview(stack.uiView)
      stack.distribution(.equalSpacing)

      view.insetsLayoutMarginsFromSafeArea = true
      stack.view.insetsLayoutMarginsFromSafeArea = true
   }
}

// MARK: - StackedScrollModels

open class ScrollStackedModelY: BaseScrollStacked, UIScrollViewDelegate {
   private var prevScrollOffset: CGFloat = 0

   override open func start() {
      super.start()

      view.delegate = self
      stack.axis(.vertical)

      view.isDirectionalLockEnabled = true
      view.showsHorizontalScrollIndicator = false
      stack.view.addAnchors
         .top(view.topAnchor)
         .leading(view.leadingAnchor)
         .trailing(view.trailingAnchor)
         .bottom(view.bottomAnchor)
         .width(view.widthAnchor)
   }

   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let velocity = scrollView.contentOffset.y - prevScrollOffset
      scrollView.contentOffset.x = 0
      prevScrollOffset = scrollView.contentOffset.y
      send(\.didScroll, (velocity, prevScrollOffset))
   }

   public func scrollViewWillEndDragging(_: UIScrollView,
                                         withVelocity velocity: CGPoint,
                                         targetContentOffset offset: UnsafeMutablePointer<CGPoint>)
   {
      send(\.willEndDragging, (velocity: velocity.y, offset: offset.pointee.y))
   }

   public func scrollViewWillBeginDragging(_: UIScrollView) {
      send(\.willBeginDragging)
   }

   public func scrollViewWillBeginDecelerating(_: UIScrollView) {
      send(\.willBeginDecelerating)
   }
}

open class ScrollStackedModelX: BaseScrollStacked, UIScrollViewDelegate {
   private var prevScrollOffset: CGFloat = 0

   override open func start() {
      super.start()
      view.delegate = self

      stack.axis(.horizontal)

      view.isDirectionalLockEnabled = true
      view.showsVerticalScrollIndicator = false

      stack.view.addAnchors
         .top(view.topAnchor)
         .leading(view.leadingAnchor)
         .trailing(view.trailingAnchor)
         .height(view.heightAnchor)
   }

   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let velocity = scrollView.contentOffset.x - prevScrollOffset
      scrollView.contentOffset.y = 0
      prevScrollOffset = scrollView.contentOffset.x
      send(\.didScroll, (velocity, prevScrollOffset))
   }

   public func scrollViewWillEndDragging(_: UIScrollView,
                                         withVelocity velocity: CGPoint,
                                         targetContentOffset offset: UnsafeMutablePointer<CGPoint>)
   {
      send(\.willEndDragging, (velocity: velocity.y, offset: offset.pointee.y))
   }

   public func scrollViewWillBeginDragging(_: UIScrollView) {
      send(\.willBeginDragging)
   }

   public func scrollViewWillBeginDecelerating(_: UIScrollView) {
      send(\.willBeginDecelerating)
   }
}

public extension BaseScrollStacked {
   @discardableResult
   func addArrangedModels(_ value: UIViewModel...) -> Self {
      stack.addArrangedModels(value)
      return self
   }

   @discardableResult
   func addArrangedModels(_ value: [UIViewModel]) -> Self {
      stack.addArrangedModels(value)
      return self
   }

   @discardableResult
   func arrangedModels(_ value: UIViewModel...) -> Self {
      stack.arrangedModels(value)
      return self
   }

   @discardableResult
   func arrangedModels(_ value: [UIViewModel]) -> Self {
      stack.arrangedModels(value)
      return self
   }

   @discardableResult
   func spacing(_ value: CGFloat) -> Self {
      stack.view.spacing = value
      return self
   }

   @discardableResult
   func scrollToBegin(_ value: Bool) -> Self {
      view.setContentOffset(.zero, animated: value)
      return self
   }

   @discardableResult
   func scrollToEnd(_ value: Bool) -> Self {
      let axis = stack.view.axis
      let endOffset = CGPoint(
         x: axis == .horizontal ? max(0, view.contentSize.width - view.bounds.size.width) : 0,
         y: axis == .vertical ? max(0, view.contentSize.height - view.bounds.size.height) : 0
      )
      view.setContentOffset(endOffset, animated: value)
      return self
   }

   @discardableResult
   func hideHorizontalScrollIndicator() -> Self {
      view.showsHorizontalScrollIndicator = false
      return self
   }

   @discardableResult
   func hideVerticalScrollIndicator() -> Self {
      view.showsVerticalScrollIndicator = false
      return self
   }

   @discardableResult
   func padding(_ value: UIEdgeInsets) -> Self {
      stack.padding(value)
      return self
   }

   @discardableResult
   func contentInset(_ value: UIEdgeInsets) -> Self {
      stack.view.addAnchors.fitToViewInsetted(view, value)
      return self
   }

   @discardableResult
   func bounce(_ value: Bool) -> Self {
      view.bounces = value
      return self
   }

   @discardableResult
   func killScroll(animated: Bool = false) -> Self {
      view.isScrollEnabled = false
      let offset = view.contentOffset
      view.setContentOffset(offset, animated: animated)
      view.isScrollEnabled = true
      return self
   }
    
   @discardableResult
   func alwaysBounceVertical(_ value: Bool) -> Self {
      view.alwaysBounceVertical = value
      return self
   }
   
   @discardableResult
   func alwaysBounceHorizontal(_ value: Bool) -> Self {
      view.alwaysBounceHorizontal = value
      return self
   }
}

public extension BaseScrollStacked {
   func applyState(_ state: State2) {
      switch state {
      case let .arrangedModels(array):
         arrangedModels(array)
      case let .addArrangedModels(array):
         addArrangedModels(array)
      case let .spacing(value):
         spacing(value)
      case let .scrollToTopAnimated(value):
         scrollToBegin(value)
      case .hideHorizontalScrollIndicator:
         hideHorizontalScrollIndicator()
      case .hideVerticalScrollIndicator:
         hideVerticalScrollIndicator()
      case let .padding(value):
         padding(value)
      case let .contentInset(value):
         contentInset(value)
      case let .bounce(value):
         bounce(value)
      }
   }
}
