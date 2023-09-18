//
//  PagingScrollViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 28.01.2023.
//

import ReactiveWorks
import UIKit

public struct PagingScrollViewModelEvents: InitProtocol {
   public init() {}

   public var didViewModelPresented: (UIViewModel, index: Int)?
   public var didPop: Bool?
}

public final class PagingScrollViewModel: ScrollViewModel, Eventable {
   public typealias Events = PagingScrollViewModelEvents

   public private(set) lazy var models = [UIViewModel]()
   private var visibleModels: [UIViewModel] { models.filter { !$0.uiView.isHidden } }

   public var events = EventsStore()
   public var currentPage: Int { pageControl.currentPage }

   public private(set) lazy var pageControlModel = PageControlModel()
   private var pageControl: UIPageControl { pageControlModel.view }

   private lazy var prefFrame = view.frame

   public override func start() {
      pagingEnabled(true)
      safeAreaOffsetDisabled()
      view.delegate = self
     // view.canCancelContentTouches = false

      view.on(\.didLayout) { [weak self] in
         guard
            let self,
            self.models.isEmpty == false,
            self.prefFrame != self.view.frame
         else { return }

         let notHiddenModels = self.models.filter { !$0.uiView.isHidden }
         let frameWidth = self.view.frame.width
         let frameHeight = self.view.frame.height
         self.view.contentSize.width = self.view.frame.width * CGFloat(notHiddenModels.count)

         notHiddenModels.enumerated().forEach {
            let subview = $1.uiView
            let xPosition = frameWidth * CGFloat($0)
            subview.frame = CGRect(x: xPosition, y: 0,
                                   width: frameWidth, height: frameHeight)
         }

         self.prefFrame = self.view.frame
      //   self.send(\.didViewModelPresented, self.models[self.pageControl.currentPage])
      }
   }

   public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      guard scrollView.frame.size.width != 0 else  {return }

      let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
      let visibleModels = visibleModels
      
      guard currentPage < visibleModels.count else {
         return
      }
      
      var currentIndex = 0
      var increment = 0
      while currentIndex < models.count && currentIndex < (currentPage + increment + 1) {
         let model = models[currentIndex]
         let isHidden = model.uiView.isHidden
         if isHidden {
            increment += 1
         }
         currentIndex += 1
      }
      
      let realPage = currentPage + increment
   
      guard realPage != pageControl.currentPage else {
         return
      }
      
      if realPage == models.count - 2 || realPage < pageControl.currentPage {
         send(\.didPop, currentPage == 0)
      }
      pageControl.currentPage = realPage
      send(\.didViewModelPresented, (models[realPage], index: realPage))
   }

   // func that scroll to image at index
   @discardableResult
   public func scrollToIndex(_ index: Int) -> Self {
      guard index < models.count else { return self }
      
      let visibleIndex = visibleIndex(index: index)
      
      let xPosition = view.frame.width * CGFloat(visibleIndex)
      UIView.animate(withDuration: 0.3) {
         self.view.setContentOffset(CGPoint(x: xPosition, y: 0), animated: false)
      } completion: { _ in
         self.scrollViewDidEndDecelerating(self.view)
      }

      pageControl.currentPage = index

      return self
   }

   @discardableResult
   public func scrollToEnd() -> Self {
      guard models.count > 1 else { return self }
      
      scrollToIndex(models.count - 1)

      return self
   }

   @discardableResult
   public func pop() -> Self {
      guard models.count > 1 else { return self }

      scrollToIndex(currentPage - 1)
   
      return self
   }
   
   public func reload() {
      view.layoutIfNeeded()
   }
   
   private func visibleIndex(index: Int) -> Int {
      var visibleIndex = 0
      for i in 0 ..< index {
         if models[i].uiView.isHidden == false {
            visibleIndex += 1
         }
      }
      return visibleIndex
   }
}

public enum PagingScrollViewModelState {
   case setViewModels([UIViewModel])
   case addViewModel(viewModel: UIViewModel)
   case deleteLast
   case deleteAll
}

extension PagingScrollViewModel: StateMachine {
   public func setState(_ state: PagingScrollViewModelState) {
      switch state {
      case let .setViewModels(models):
         self.models.forEach { $0.uiView.removeFromSuperview() }
         self.models = models
         pageControl.currentPage = 0
         pageControl.numberOfPages = models.count

         guard models.isEmpty == false else {
            view.contentSize.width = 0
            return
         }

         let frameWidth = view.frame.width
         let frameHeight = view.frame.height
         view.contentSize.width = self.view.frame.width * CGFloat(models.count)

         models.enumerated().forEach {
            let subview = $1.uiView
            let xPosition = frameWidth * CGFloat($0)
            subview.frame = CGRect(x: xPosition, y: 0, width: frameWidth, height: frameHeight)

            view.addSubview(subview)
         }

         prefFrame = view.frame

         send(\.didViewModelPresented, (models[pageControl.currentPage], index: pageControl.currentPage))

      case let .addViewModel(model):
         models.append(model)

         let subview = model.uiView
         let xPosition = view.contentSize.width // view.frame.width * CGFloat($0)
         subview.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height)

         view.contentSize.width += view.frame.width
         view.addSubview(subview)

         pageControl.numberOfPages = models.count

         if models.count == 1 {
            send(\.didViewModelPresented, (models[pageControl.currentPage], index: pageControl.currentPage))
         }

      case .deleteLast:
         models.last?.uiView.removeFromSuperview()
         models.removeLast()
         view.contentSize.width = self.view.frame.width * CGFloat(models.count)
         pageControl.numberOfPages = models.count
         //setState(.setViewModels(models))
      case .deleteAll:
         models.forEach { $0.uiView.removeFromSuperview() }
         models.removeAll()
         view.contentSize.width = 0
         pageControl.numberOfPages = 0
         pageControl.currentPage = 0
         view.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
      }
   }
}

public final class PageControlModel: BaseViewModel<UIPageControl> {
    @discardableResult public func pageIndicatorTintColor(_ value: UIColor) -> Self {
        view.pageIndicatorTintColor = value
        return self
    }

    @discardableResult public func currentPageIndicatorTintColor(_ value: UIColor) -> Self {
        view.currentPageIndicatorTintColor = value
        return self
    }
}
