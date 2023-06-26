//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks

public protocol Scenarible: AnyObject {
   associatedtype Scenery: Scenario
   var scenario: Scenery { get }
}

public protocol Scenarible2: Scenarible {
   associatedtype Scenery2: Scenario
   var scenario2: Scenery2 { get }
}

public protocol Scenarible3: Scenarible2 {
   associatedtype Scenery3: Scenario
   var scenario3: Scenery3 { get }
}

// MARK: - Scenario protocol and base scenario

public protocol Scenario {
   func configure()
   func configureAndStart()
   func sendStartEvent()
}

public protocol ScenarioEvents {}

public protocol ScenarioParams {
   associatedtype Asset: AssetRoot
   associatedtype ScenarioInputEvents: ScenarioEvents
   associatedtype ScenarioModelState: Any
   associatedtype ScenarioWorks: WorksProtocol
}

open class BaseParamsScenario<Params: ScenarioParams>: BaseWorkableScenario<
   Params.ScenarioInputEvents,
   Params.ScenarioModelState,
   Params.ScenarioWorks
> {}

open class BaseScenarioClass<State>: Scenario {
   public private(set) lazy var start = Work<Void, Void>()

   public private(set) var isConfigured: Bool = false

   public init(stateDelegate: ((State) -> Void)?) {
      if let setStateFunc = stateDelegate {
         setState = setStateFunc
      }
   }

   open func configure() {
      if isConfigured {
         assertionFailure("Scenario is already configured. Use configureIfNeededAndStart() or sendStartEvent()")
      }
      isConfigured = true
   }

   public func configureAndStart() {
      if isConfigured {
         sendStartEvent()
         return
      }

      configure()
      isConfigured = true
      sendStartEvent()
   }

   public func sendStartEvent() {
      if !isConfigured {
         assertionFailure("Scenario is Not configured. Use configure() or configureIfNeededAndStart()")
      }
      start.sendAsyncEvent()
   }

   public var setState: (State) -> Void = { _ in
      assertionFailure("stateDelegate (setState:) did not injected into Scenario")
   }
}

open class BaseWorkableScenario<Events: ScenarioEvents, State, Works>: BaseScenarioClass<State> {
   public var works: Works
   public var events: Events

   public required init(works: Works, stateDelegate: ((State) -> Void)?, events: Events) {
      self.events = events
      self.works = works

      super.init(stateDelegate: stateDelegate)
   }
}

open class BaseScenario<State, Events: ScenarioEvents>: BaseScenarioClass<State> {
   public var events: Events

   public required init(stateDelegate: ((State) -> Void)?, events: Events) {
      self.events = events

      super.init(stateDelegate: stateDelegate)
   }
}
