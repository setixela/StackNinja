//
//  Presenting.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 18.08.2022.
//

import ReactiveWorks
import Foundation

public protocol PresenterProtocol {
   var cellType: String { get }

   func viewModel(for item: Any, indexPath: IndexPath) -> UIViewModel
}

open class CellPresenterWork<In, Out: UIViewModel>: Work<(item: In, indexPath: IndexPath), Out>, PresenterProtocol {
   public func viewModel(for item: Any, indexPath: IndexPath) -> UIViewModel {
      doSync((item: item, indexPath: indexPath) as? (In, IndexPath)) ?? { fatalError("Maybe, forgot to call: work.success(cell)") }()
   }

   public var cellType: String {
      let name = String(describing: In.self)
      return name
   }
}
