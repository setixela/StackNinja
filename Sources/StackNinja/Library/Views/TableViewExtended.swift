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

   private var isAutoReload = false

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

   func setAutoReload() {
      isAutoReload = true
      let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTable))
      gesture.cancelsTouchesInView = false
      addGestureRecognizer(gesture)
   }

   override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)

      if isAutoReload {
         reloadData()
      }
   }

   @objc private func didTapTable() {
      reloadData()
   }
}
