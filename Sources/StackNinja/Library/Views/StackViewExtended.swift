//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public final class StackViewExtended: UIStackView, Eventable, ViewModelStorageView, LoadableView {
   public typealias Events = ViewEvents
   
   private var isGestured = false
   
   public var events: EventsStore = .init()
   
   weak var backView: UIView?
   
   public var viewModel: UIViewModel?
   
   public var activityModel: UIViewModel?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      axis = .vertical
      clipsToBounds = false
      layer.masksToBounds = false
   }
   
   @available(*, unavailable)
   required init(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   @discardableResult
   public override func startTapGestureRecognize(cancelTouch: Bool = false) -> Self {
      let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
      gesture.cancelsTouchesInView = cancelTouch
      addGestureRecognizer(gesture)
      isUserInteractionEnabled = true
      
      return self
   }
   
   @objc public override func didTap() {
      send(\.didTap)
   }
   
   public override func layoutSubviews() {
      super.layoutSubviews()

      send(\.didLayout)
      
      guard let backView = backView else {
         return
      }
      
      sendSubviewToBack(backView)
   }
   
   public override func willMove(toSuperview newSuperview: UIView?) {
      super.willMove(toSuperview: newSuperview)
      
      if newSuperview == nil {
         send(\.willDisappear)
      } else {
         send(\.willMoveToSuperview)
      }
   }
   
   public override func didMoveToSuperview() {
      super.didMoveToSuperview()
      
      send(\.didMoveToSuperview)
   }
   
   public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
      if !clipsToBounds, !isHidden, alpha > 0 {
         let button = subviews.flatMap {
            $0.subviews.flatMap(\.subviews)
         }
            .filter {
               ($0 is (any Tappable)) && ($0.isHidden == false)
            }
            .last(where: {
               let subPoint = $0.convert(point, from: self)
               return $0.hitTest(subPoint, with: event) != nil
            })
         
         if button != nil {
            return button
         }
      }
      
      return super.hitTest(point, with: event)
   }
}

public extension StackViewExtended {
   func addArrangedSubviews(_ views: UIView...) {
      views.forEach { view in
         self.addArrangedSubview(view)
      }
   }
}

public extension StackViewExtended {
   func addViewModels(_ models: UIViewModel...) {
      models.forEach { model in
         self.addArrangedSubview(model.uiView)
      }
   }
}
