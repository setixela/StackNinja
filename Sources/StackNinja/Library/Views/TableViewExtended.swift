//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public final class TableViewExtended: UITableView {
   public var isNeedsLayoutWhenContentChanged: Bool = false
   
   public override var contentSize: CGSize {
      didSet {
         if isNeedsLayoutWhenContentChanged { invalidateIntrinsicContentSize() }
      }
   }
   
   public override var intrinsicContentSize: CGSize {
      if isNeedsLayoutWhenContentChanged {
         layoutIfNeeded()
         return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
      } else {
         return super.intrinsicContentSize
      }
   }
}

