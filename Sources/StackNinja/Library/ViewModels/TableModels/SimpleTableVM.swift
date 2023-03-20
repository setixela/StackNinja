//
//  TableViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 18.07.2022.
//

import ReactiveWorks
import UIKit

public struct TableSection {
   public let title: String
   public let models: [UIViewModel]
}

public struct TableViewEvents: InitProtocol, ScrollEventsProtocol {
   public var didScroll: CGFloat?
   public var willEndDragging: CGFloat?

   public init() {}

   public var cellForRow: ((UIViewModel) -> Void)?
   public var didSelectRow: IndexPath?
   public var reloadData: Void?
}

public final class SimpleTableVM: BaseViewModel<TableViewExtended>, UIScrollViewDelegate {
   public typealias Events = TableViewEvents

   public var events = EventsStore()

   private var cellName = "cellName"

   private var models: [UIViewModel] = []
   private var sections: [TableSection] = []
   private var isMultiSection: Bool = false

   private var prevScrollOffset: CGFloat = 0

   override public func start() {
      view.delegate = self
      view.dataSource = self
      view.register(UITableViewCell.self, forCellReuseIdentifier: cellName)
   }

   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let velocity = scrollView.contentOffset.y - prevScrollOffset
      prevScrollOffset = scrollView.contentOffset.y
      send(\.didScroll, velocity)
   }

   public func scrollViewWillEndDragging(_: UIScrollView,
                                         withVelocity velocity: CGPoint,
                                         targetContentOffset _: UnsafeMutablePointer<CGPoint>)
   {
      send(\.willEndDragging, velocity.y)
   }

}

extension SimpleTableVM: Stateable {
   public typealias State = ViewState
}

extension SimpleTableVM: Eventable {}

extension SimpleTableVM: UITableViewDelegate {
   public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      send(\.didSelectRow, indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
   }
}

extension SimpleTableVM: UITableViewDataSource {
   public func numberOfSections(in _: UITableView) -> Int {
      isMultiSection ? sections.count : 1
   }

   public func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
      isMultiSection ? sections[section].title : nil
   }

   public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
      isMultiSection ? sections[section].models.count : models.count
   }

   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellName) ?? UITableViewCell()

      if !hasSubcriberForEvent(\.cellForRow) {
         let model = isMultiSection ? sections[indexPath.section].models[indexPath.row] : models[indexPath.row]
         let modelView = model.uiView
         cell.contentView.subviews.forEach { $0.removeFromSuperview() }
         cell.contentView.addSubview(modelView)
         modelView.addAnchors.fitToView(cell.contentView)

         return cell
      } else {
         send(\.cellForRow, ({ viewModel in
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            cell.contentView.addSubview(viewModel.uiView)
            viewModel.uiView.addAnchors.fitToView(cell.contentView)
         }))

         return cell
      }
   }

   public func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
      UITableView.automaticDimension
   }

   public func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
      UITableView.automaticDimension
   }
}

public extension SimpleTableVM {
   @discardableResult func models(_ value: [UIViewModel]) -> Self {
      isMultiSection = false
      models = value
      view.reloadData()
      return self
   }

   @discardableResult func sections(_ value: [TableSection]) -> Self {
      isMultiSection = true
      sections = value
      view.reloadData()
      return self
   }

   @discardableResult func setNeedsLayoutWhenContentChanged() -> Self {
      view.isNeedsLayoutWhenContentChanged = true
      return self
   }
}
