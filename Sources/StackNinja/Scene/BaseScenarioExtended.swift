//
//  BaseScenarioExtended.swift
//  Oporle
//
//  Created by Aleksandr Solovyev on 17.03.2023.
//

open class BaseScenarioExtended<Params: ScenarioParams>: BaseScenario<
   Params.ScenarioInputEvents,
   Params.ScenarioModelState,
   Params.ScenarioWorks
> {}
