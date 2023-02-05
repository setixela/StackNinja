//
//  ViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 17.12.2022.
//

import ReactiveWorks
import UIKit

open class ViewModel: BaseViewModel<ViewExtended> {}

extension ViewModel: Stateable {
   public typealias State = ViewState
}
