//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 04.02.2023.
//

import ReactiveWorks

public protocol HeaderBodyFooterStackProtocol {
   var headerStack: StackModel { get }
   var bodyStack: StackModel { get }
   var footerStack: StackModel { get }
}

open class HeaderBodyFooterStackModel: BaseViewModel<StackViewExtended>, HeaderBodyFooterStackProtocol {
   public let headerStack = StackModel(.axis(.vertical),
                                       .alignment(.fill),
                                       .distribution(.fill))
   public let bodyStack = StackModel(.axis(.vertical),
                                     .alignment(.fill),
                                     .distribution(.fill))
   public let footerStack = StackModel(.axis(.vertical),
                                       .alignment(.fill),
                                       .distribution(.fill))

   override open func start() {
      axis(.vertical)
      alignment(.fill)
      distribution(.fill)
      arrangedModels([
         headerStack,
         bodyStack,
         footerStack,
      ])
   }
}

extension HeaderBodyFooterStackModel: Stateable2 {
   public typealias State = StackState
   public typealias State2 = ViewState
}
