//
//  TableItemsModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 17.08.2022.
//

import ReactiveWorks
import UIKit

public protocol CellModifierProtocol {}

public protocol DisableSelectModifier: CellModifierProtocol {}

public protocol SectionProtocol {
   associatedtype Item
   var items: [Item] { get set }
}

public class TableItemsSection {
   public let title: String?
   public var items: [Any] = []
   public var isCollapsed: Bool = false

   public init(title: String? = nil, items: [Any] = [], isCollapsed: Bool = false) {
      self.title = title
      self.items = items
      self.isCollapsed = isCollapsed
   }
}

public struct TableItemsEvents: ScrollEventsProtocol {
   public init() {}

   public var didSelectRow: (IndexPath, Int)?
   public var deleteItemAtIndex: Int?
   public var didSelectItemAtIndex: Int?
   public var didSelectItem: Any?
   public var willDisplayCellAtIndexPath: (UITableViewCell, IndexPath)?
   public var didEndDisplayCellAtIndexPath: (UITableViewCell, IndexPath)?

   public var presentedIndex: Int?

   // TODO: - Обьединять ивенты как Стейты
   public var didScroll: (velocity: CGFloat, offset: CGFloat)?
   public var willEndDragging: (velocity: CGFloat, offset: CGFloat)?
   public var requestPagination: Void?
   public var didLayout: Void?

   // refresh
   public var refresh: Void?
}

public final class TableItemsModel: BaseViewModel<TableViewExtended>,
   Presenting,
   UITableViewDelegate,
   UITableViewDataSource
{
   public typealias Events = TableItemsEvents
   public var events: EventsStore = .init()

   private var isMultiSection: Bool = false

   public var presenters: [String: PresenterProtocol] = [:]

   private var items: [Any] = [] {
      willSet {
         if items.count == newValue.count {
            isPaginationDisabled = true
         } else {
            isPaginationDisabled = false
         }
      }
      didSet {
         print("TABLE SET\n")
         isRequestedPagination = false
         cache = [:]
      }
   }

   private var itemSections: [TableItemsSection] = [] {
      willSet {
         let itemSectionsSum = itemSections.map(\.items.count).reduce(0, +)
         let newValueSum = newValue.map(\.items.count).reduce(0, +)
         if itemSectionsSum == newValueSum {
            isPaginationDisabled = true
         } else {
            isPaginationDisabled = false
         }
      }
      didSet {
         print("TABLE SET\n")
         isRequestedPagination = false
         cache = [:]
      }
   }

   private var deleteModeOn: Bool = false
   private var deletableValues: [Bool] = []
   
   private var prevScrollOffset: CGFloat = 0

   private var isRequestedPagination = false
   private var isPaginationDisabled = false

   private lazy var refreshControl = UIRefreshControl()

   private lazy var headerState: [LabelState] = []
   private lazy var headerBackColor: UIColor = view.backgroundColor ?? .clear

   private var cacheSize = 50

   private var cache: [String: UIView] = [:] {
      didSet {
         if cache.count > cacheSize {
            cache = [:]
         }
      }
   }

   // MARK: - Start

   override public func start() {
      view.delegate = self
      view.dataSource = self
      view.separatorColor = .clear
      view.clipsToBounds = true
      view.layer.masksToBounds = true
      view.rowHeight = UITableView.automaticDimension
      view.estimatedRowHeight = UITableView.automaticDimension
      view.on(\.didLayout, self) {
         $0.send(\.didLayout)
      }

      if #available(iOS 15.0, *) {
         view.sectionHeaderTopPadding = 0
      }
   }

   // MARK: -  UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
   
   public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
      -> UISwipeActionsConfiguration?
   {
      let itemIndex = indexPath.row
      let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
         self.items.remove(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with: .fade)
         self.send(\.deleteItemAtIndex, itemIndex)
         completionHandler(true)
      }
      deleteAction.image = UIImage(systemName: "trash")
      deleteAction.backgroundColor = .systemRed
      let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
      return configuration
   }

   public func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      if deleteModeOn, deletableValues.indices.contains(indexPath.row), deletableValues[indexPath.row] {
         return true
      }
      return false
   }

   public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      var itemIndex = indexPath.row
      if isMultiSection == false {
         guard itemIndex >= 0 && itemIndex < items.count && !(items[itemIndex] is DisableSelectModifier) else {
             return
         }
         send(\.didSelectItem, items[itemIndex])
      } else {
         guard !(itemSections[indexPath.section].items[indexPath.row] is (DisableSelectModifier)) else {
            return
         }
         send(\.didSelectItem, itemSections[indexPath.section].items[indexPath.row])
      }

      for i in 0 ..< indexPath.section {
         itemIndex += view.numberOfRows(inSection: i)
      }

      send(\.didSelectRow, (indexPath, itemIndex))
      send(\.didSelectItemAtIndex, itemIndex)
      tableView.deselectRow(at: indexPath, animated: true)
   }

   public func numberOfSections(in _: UITableView) -> Int {
      isMultiSection ? itemSections.count : 1
   }

   public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
      isMultiSection ? itemSections[section].items.count : items.count
   }

   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let item = isMultiSection ? itemSections[indexPath.section].items[indexPath.row] : items[indexPath.row]

      let cellName = String(describing: type(of: item))

      view.register(TableCell.self, forCellReuseIdentifier: cellName)

      let cell = tableView.dequeueReusableCell(withIdentifier: cellName) ?? TableCell()

      if isMultiSection {
         let section = itemSections[indexPath.section]
         if section.isCollapsed {
            cell.isHidden = true
         } else {
            cell.isHidden = false
         }
      }

      let key = String("\(indexPath.section) \(indexPath.row)")
      var modelView: UIView? = cache[key]

      if modelView == nil {
         let presenter = presenters[cellName]
         let model = presenter?.viewModel(for: item, indexPath: indexPath)
         modelView = model?.uiView

         cache[key] = modelView
      }

      cell.contentView.backgroundColor = view.backgroundColor
      cell.contentView.subviews.forEach { $0.removeFromSuperview() }
      cell.contentView.addSubview(modelView ?? UIView())
      modelView?.addAnchors.fitToView(cell.contentView)
      cell.contentView.setNeedsLayout()

      send(\.presentedIndex, indexPath.row)

      return cell
   }

   public func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if isMultiSection {
         let section = itemSections[indexPath.section]
         if section.isCollapsed {
            return 0
         } else {
            return UITableView.automaticDimension
         }
      } else {
         return UITableView.automaticDimension
      }
   }

   public func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
      UITableView.automaticDimension
   }

   private var viewForHeaderRequest: ((Int, TableItemsSection) -> UIViewModel)?

   @discardableResult
   public func headerModelFactory(_ factory: @escaping (Int, TableItemsSection) -> UIViewModel) -> Self {
      viewForHeaderRequest = factory
      return self
   }
   
   @discardableResult
   public func setSectionCollapsed(_ isCollapsed: Bool, at index: Int) -> Self {
      if isMultiSection {
         itemSections[safe: index]?.isCollapsed = isCollapsed
      }
      reload()
      return self
   }

   @discardableResult
   public func toggleSectionCollapsed(at index: Int, animated: Bool = true) -> Self {
      if isMultiSection, let section = itemSections[safe: index] {
         itemSections[safe: index]?.isCollapsed = !section.isCollapsed
      }
      if animated {
         let sectionToReload = index
         let rowsInSection = view.numberOfRows(inSection: sectionToReload)
         var indexPathsToReload: [IndexPath] = []

         for row in 0 ..< rowsInSection {
            indexPathsToReload.append(IndexPath(row: row, section: sectionToReload))
         }

         view.reloadRows(at: indexPathsToReload, with: .automatic)
      } else {
         reload()
      }
      view.reloadSections(IndexSet(integer: index), with: .fade)
      
      return self
   }

   public func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      guard isMultiSection else { return nil }

      if let viewForHeaderRequest {
         return viewForHeaderRequest(section, itemSections[section]).uiView
      } else {
         let text = itemSections[section].title ?? ""
         let view = LabelModel()
            .padding(.init(top: 4, left: 16, bottom: 4, right: 16))
            .set(headerState)
            .text(text)
            .backColor(headerBackColor)
            .uiView

         return view
      }
   }

   public func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
      guard isMultiSection else { return 0 }

      return UITableView.automaticDimension // 36
   }

   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let velocity = scrollView.contentOffset.y - prevScrollOffset
      prevScrollOffset = scrollView.contentOffset.y
      send(\.didScroll, (velocity, prevScrollOffset))

      guard isRequestedPagination == false, isPaginationDisabled == false else { return }

      let pos = scrollView.contentOffset.y
      if pos > view.contentSize.height - scrollView.frame.size.height * 2 {
         print("TABLE REQUEST PAGING")

         send(\.requestPagination)
         isRequestedPagination = true
      }
   }

   public func scrollViewWillEndDragging(_: UIScrollView,
                                         withVelocity velocity: CGPoint,
                                         targetContentOffset offset: UnsafeMutablePointer<CGPoint>)
   {
      send(\.willEndDragging, (velocity: velocity.y, offset: offset.pointee.y))
   }

   // Refresh

   @objc func refresh(_: AnyObject) {
      view.isScrollEnabled = false
      send(\.refresh)
      refreshControl.endRefreshing()
      view.isScrollEnabled = true
   }

   public func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      send(\.willDisplayCellAtIndexPath, (cell, indexPath))
   }

   public func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      send(\.didEndDisplayCellAtIndexPath, (cell, indexPath))
   }
}

extension TableItemsModel: Stateable {
   public typealias State = ViewState
}

extension TableItemsModel: Eventable {}

public extension TableItemsModel {
   @discardableResult func headerParams(labelState: [LabelState],
                                        backColor: UIColor) -> Self
   {
      headerState = labelState
      headerBackColor = backColor
      return self
   }

   @discardableResult func cacheSize(_ value: Int) -> Self {
      cacheSize = value
      return self
   }

   @discardableResult func items(_ value: [Any]) -> Self {
      items = value
      view.reloadData()
      return self
   }
   
   @discardableResult func deletableValues(_ value: [Bool]) -> Self {
      deletableValues = value
      return self
   }

   @discardableResult func itemSections(_ value: [TableItemsSection]) -> Self {
      itemSections = value
      isMultiSection = true
      view.reloadData()
      return self
   }

   @discardableResult func presenters(_ value: PresenterProtocol...) -> Self {
      presenters.removeAll()
      value.forEach {
         let key = $0.cellType
         self.presenters[key] = $0
      }
      return self
   }

   @discardableResult func presenters(_ value: [PresenterProtocol]) -> Self {
      presenters.removeAll()
      value.forEach {
         let key = $0.cellType
         self.presenters[key] = $0
      }
      return self
   }

   @discardableResult func updateItemAtIndex(_ value: Any,
                                             index: Int,
                                             animation _: UITableView.RowAnimation = .none) -> Self
   {
      items[index] = value
      let indexPath = IndexPath(item: index, section: 0)
      view.reloadRows(at: [indexPath], with: .automatic)
      return self
   }

   @discardableResult func separatorStyle(_ value: UITableViewCell.SeparatorStyle) -> Self {
      view.separatorStyle = value
      return self
   }

   @discardableResult func separatorColor(_ value: UIColor) -> Self {
      view.separatorColor = value
      return self
   }

   @discardableResult func reload() -> Self {
      view.reloadData()
      return self
   }

   @discardableResult func activateRefreshControl(text: String = "", color: UIColor? = nil) -> Self {
      refreshControl.attributedTitle = NSAttributedString(string: text)
      refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
      refreshControl.tintColor = color ?? refreshControl.tintColor
      refreshControl.transform = CGAffineTransformMakeScale(0.70, 0.70)
      view.refreshControl = refreshControl
      return self
   }

   @discardableResult func setNeedsLayoutWhenContentChanged() -> Self {
      view.isNeedsLayoutWhenContentChanged = true
      return self
   }

   @discardableResult func setAutoReload() -> Self {
      view.setAutoReload()
      return self
   }

   @discardableResult func reset() -> Self {
      if isMultiSection {
         itemSections = []
         view.reloadData()
      } else {
         items = []
         view.reloadData()
      }

      isRequestedPagination = false
      isPaginationDisabled = false

      return self
   }

   @discardableResult func footerModel(_ value: UIViewModel) -> Self {
      view.tableFooterView = value.uiView
      return self
   }
   
   @discardableResult func deleteModeOn(_ value: Bool) -> Self {
      deleteModeOn = value
      return self
   }
}

public final class TableCell: UITableViewCell {
   override public func prepareForReuse() {
      super.prepareForReuse()
   }
}
