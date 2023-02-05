//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 04.02.2023.
//

import ReactiveWorks

public protocol HeaderBodyCaptionFooterStackProtocol {
   var headerStack: StackModel { get }
   var bodyStack: StackModel { get }
   var captionStack: StackModel { get }
   var footerStack: StackModel { get }
}

open class HeaderBodyCaptionFooterStackModel: BaseViewModel<StackViewExtended>, HeaderBodyCaptionFooterStackProtocol {
   public let headerStack = StackModel(.axis(.vertical),
                                       .alignment(.fill),
                                       .distribution(.fill))
   public let bodyStack = StackModel(.axis(.vertical),
                                     .alignment(.fill),
                                     .distribution(.fill))
   public let captionStack = StackModel(.axis(.vertical),
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
         captionStack,
         footerStack,
      ])
   }
}

extension HeaderBodyCaptionFooterStackModel: Stateable2 {
   public typealias State = StackState
   public typealias State2 = ViewState
}
