//
//  ScenaribleSceneParams.swift
//  Oporle
//
//  Created by Aleksandr Solovyev on 17.03.2023.
//

public protocol ScenaribleSceneParams: SceneParams, ScenarioParams where ScenarioWorks: WorksProtocol {
   associatedtype Scenery: BaseScenario<ScenarioInputEvents, ScenarioModelState, ScenarioWorks>
}
