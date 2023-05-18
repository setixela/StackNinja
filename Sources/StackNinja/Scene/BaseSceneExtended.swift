//
//  BaseScenarioScene.swift
//  Oporle
//
//  Created by Aleksandr Solovyev on 18.03.2023.
//

import ReactiveWorks

public protocol ScenaribleSceneProtocol: BaseSceneModel<
   Self.Params.Models.VCModel,
   Self.Params.Models.MainViewModel,
   Self.Params.Asset,
   Self.Params.InOut.Input,
   Self.Params.InOut.Output
> {
   associatedtype Params: ScenaribleSceneParams

   var scenario: Params.Scenery { get set }
}

public extension ScenaribleSceneProtocol where Self: StateMachine, ModelState == Params.ScenarioModelState {
   private func makeScenario(_ events: Params.ScenarioInputEvents) -> Params.Scenery {
      Params.Scenery(works: Params.ScenarioWorks(), stateDelegate: stateDelegate, events: events)
   }

   func initScenario(_ events: Params.ScenarioInputEvents) {
      scenario = makeScenario(events)
   }
}

open class BaseSceneExtended<Params: ScenaribleSceneParams>: BaseSceneModel<
   Params.Models.VCModel,
   Params.Models.MainViewModel,
   Params.Asset,
   Params.InOut.Input,
   Params.InOut.Output
>, ScenaribleSceneProtocol {
   public lazy var scenario: Params.Scenery = { fatalError() }()

   public typealias ModelState = Params.ScenarioModelState
}
