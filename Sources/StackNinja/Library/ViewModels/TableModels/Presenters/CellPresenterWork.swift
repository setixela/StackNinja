//
//  Presenting.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 18.08.2022.
//

import ReactiveWorks

public protocol PresenterProtocol {
   var cellType: String { get }

   func viewModel(for item: Any, index: Int) -> UIViewModel
}

open class CellPresenterWork<In, Out: UIViewModel>: Work<(item: In, index: Int), Out>, PresenterProtocol {
   public func viewModel(for item: Any, index: Int) -> UIViewModel {
      doSync((item: item, index: index) as? (In, Int)) ?? { fatalError("Maybe, forgot to call: work.success(cell)") }()
   }

   public var cellType: String {
      let name = String(describing: In.self)
      return name
   }
}
