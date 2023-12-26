//
//  StackItemsModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 23.08.2022.
//

import ReactiveWorks
import UIKit

public enum StackItemsState {
   case items([Any])
   case presenters([PresenterProtocol])
   case activateSelector

   case removeAllExceptIndex(Int)
}

public struct StackItemsEvents: InitProtocol {
   public init() {}
   public var didSelectRow: Int?
}

public final class StackItemsModel: StackModel, Presenting, Eventable, Stateable3 {
   public var presenters: [String: PresenterProtocol] = [:]

   public typealias Events = StackItemsEvents
   public var events = EventsStore()

   private var isSelectEnabled = false

   public private(set) var items: [Any] = []
}

public extension StackItemsModel {
   func applyState(_ state: StackItemsState) {
      switch state {
      case let .items(items):
         self.items = items
         arrangedModels(items.enumerated().map {
            let model = makeModelForData($0.1, index: $0.0)
            if isSelectEnabled {
               let rec = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
               rec.name = String($0.0)
               model.uiView.addGestureRecognizer(rec)
            }
            return model
         })
      case let .presenters(presenters):
         self.presenters.removeAll()
         presenters.forEach {
            let key = $0.cellType
            self.presenters[key] = $0
         }
      case .activateSelector:
         isSelectEnabled = true
      case let .removeAllExceptIndex(index):
         view.arrangedSubviews.enumerated().forEach {
            guard $0.offset != index else { return }
            $0.element.removeFromSuperview()
         }

         if index < items.count {
            items = [items[index]]
         } else {
            items = []
         }
      }
   }

   private func makeModelForData(_ item: Any, index: Int) -> UIViewModel {
      let cellName = String(describing: type(of: item))

      guard let presenter = presenters[cellName] else { return ViewModel() }

      let model = presenter.viewModel(for: item, indexPath: .init(row: index, section: 0))
      return model
   }

   @objc func didTap(_ sender: UIGestureRecognizer) {
      send(\.didSelectRow, Int(sender.name ?? "0") ?? 0)
   }
}

public protocol Presenting {
   var presenters: [String: PresenterProtocol] { get set }
}
