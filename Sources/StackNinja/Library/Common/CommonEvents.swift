//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public protocol ViewEventsProtocol: InitProtocol {
   var willMoveToSuperview: Void?  { get set }
   var didMoveToSuperview: Void? { get set }
   var willDisappear: Void? { get set }
   var didLayout: Void? { get set }
}

public struct ViewEvents: ViewEventsProtocol {
   public init() {}

   public var willMoveToSuperview: Void?
   public var didMoveToSuperview: Void?
   public var willDisappear: Void?
   public var didLayout: Void?

   public var didTap: Void?
   public var didSelect: String?
   public var didSelectRangeIndex: Int?
}

public typealias ButtonEvents = ViewEvents

public protocol ScrollEventsProtocol: InitProtocol {
   // TODO: - Обьединять ивенты как Стейты
   var didScroll: CGFloat? { get set }
   var willEndDragging: CGFloat? { get set }
}

public struct ScrollEvents: ScrollEventsProtocol {
   public init() {}

   public var didScroll: CGFloat?
   public var willEndDragging: CGFloat?
   public var willBeginDragging: Void?
   public var willBeginDecelerating: Void?
}

public struct SwitchEvent: InitProtocol {
   public init() {}

   public var turnedOn: Void?
   public var turnedOff: Void?
   public var turned: Bool?
}

public protocol Tappable: Eventable where Events == ButtonEvents {}
