//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public final class ScrollViewExtended: UIScrollView, LoadableView, Eventable {
   public typealias Events = ViewEvents
   
   public var events: EventsStore = .init()
   
   public var activityModel: UIViewModel?
   
   var isNeedPassThroughTuches = false
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   @available(*, unavailable)
   required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   public override func didMoveToSuperview() {
      send(\.didMoveToSuperview)
   }
   
   public override func layoutSubviews() {
      super.layoutSubviews()
      
      send(\.didLayout)
   }
   
   public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      
      if isNeedPassThroughTuches {
         next?.touchesBegan(touches, with: event)
      }
   }
   
   public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      
      if isNeedPassThroughTuches {
         next?.touchesEnded(touches, with: event)
      }
   }
}
