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

   public var didViewModelPresented: UIViewModel?
}

public final class PagingScrollViewModel: ScrollViewModel, Eventable {
   public typealias Events = PagingScrollViewModelEvents

   public private(set) lazy var models = [UIViewModel]()

   public var events = EventsStore()
   public var currentPage: Int { pageControl.currentPage }

   private lazy var pageControl = UIPageControl()

   private lazy var prefFrame = view.frame

   public override func start() {
      pagingEnabled(true)
      safeAreaOffsetDisabled()
      view.delegate = self

      view.on(\.didLayout) { [weak self] in
         guard
            let self,
            self.models.isEmpty == false
//            self.prefFrame != self.view.frame
         else { return }

         self.models.enumerated().forEach {
            let subview = $1.uiView
            let xPosition = self.view.frame.width * CGFloat($0)
            subview.frame = CGRect(x: xPosition, y: 0,
                                   width: self.view.frame.width, height: self.view.frame.height)
            self.view.contentSize.width = self.view.frame.width * CGFloat($0 + 1)
         }

         self.prefFrame = self.view.frame
         self.send(\.didViewModelPresented, self.models[self.pageControl.currentPage])
      }

       view.layoutIfNeeded()
   }

   public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
      pageControl.currentPage = currentPage
      guard currentPage < models.count else { 
         return
      }
      send(\.didViewModelPresented, models[currentPage])
   }
}

public enum PagingScrollViewModelState {
   case setViewModels([UIViewModel])
   case addViewModel(viewModel: UIViewModel)
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

         models.enumerated().forEach {
            let subview = $1.uiView
            let xPosition = view.frame.width * CGFloat($0)
            subview.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height)
            view.contentSize.width = self.view.frame.width * CGFloat($0 + 1)

            view.addSubview(subview)
         }

          view.setNeedsLayout()
         send(\.didViewModelPresented, models[pageControl.currentPage])

      case let .addViewModel(model):
         models.append(model)

         let subview = model.uiView
         let xPosition = view.contentSize.width // view.frame.width * CGFloat($0)
         subview.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height)

         view.contentSize.width += view.frame.width
         view.addSubview(subview)

         pageControl.numberOfPages = models.count

         if models.count == 1 {
            send(\.didViewModelPresented, models[pageControl.currentPage])
         }
          view.setNeedsLayout()
      }
   }
}

