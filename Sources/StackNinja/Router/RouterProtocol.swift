//
//  RouterProtocol.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 03.06.2022.
//

import ReactiveWorks
import UIKit

public protocol NavigateProtocol {
   associatedtype Asset: AssetRoot
   
   var nc: UINavigationController { get }

   func start()
   
   func route<In, Out, T: BaseScene<In, Out> & SMP>(
      _ navType: NavType,
      scene: KeyPath<Asset.Scene, T>?,
      payload: T.Input?,
      finishWork: Work<Void, Out>?)
   
   func pop()
   func popToRoot()
}

public protocol RouterProtocol: NavigateProtocol{}
