//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public final class TableViewExtended: UITableView, Eventable {
   public typealias Events = ViewEvents
   public var events: EventsStore = .init()

   public var isNeedsLayoutWhenContentChanged: Bool = false

   override public var contentSize: CGSize {
      didSet {
         if isNeedsLayoutWhenContentChanged { invalidateIntrinsicContentSize() }
      }
   }

   override public var intrinsicContentSize: CGSize {
      if isNeedsLayoutWhenContentChanged {
         layoutIfNeeded()
         let height = contentSize.height
         return CGSize(width: UIView.noIntrinsicMetric, height: height)
      } else {
         return super.intrinsicContentSize
      }
   }

   override public func layoutSubviews() {
      super.layoutSubviews()

      send(\.didLayout)
   }
}
