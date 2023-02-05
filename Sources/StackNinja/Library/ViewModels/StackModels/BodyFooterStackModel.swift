//
//  StackWithBottomPanelModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 24.06.2022.
//

import ReactiveWorks
import UIKit

public protocol BodyFooterStackProtocol {
   var bodyStack: StackModel { get }
   var footerStack: StackModel { get }
}

open class BodyFooterStackModel: BaseViewModel<StackViewExtended>, BodyFooterStackProtocol {
   public let bodyStack = StackModel(.axis(.vertical),
                                     .alignment(.fill),
                                     .distribution(.fill))
   public let footerStack = StackModel(.axis(.vertical),
                                       .alignment(.fill),
                                       .distribution(.fill))

   override open func start() {
      set(.axis(.vertical))
      set(.alignment(.fill))
      set(.distribution(.fill))
      set(.arrangedModels([
         bodyStack,
         footerStack,
      ]))
   }
}

extension BodyFooterStackModel: Stateable2 {
   public typealias State = StackState
   public typealias State2 = ViewState
}
