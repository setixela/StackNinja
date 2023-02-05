//
//  Wrapper.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 15.08.2022.
//

import ReactiveWorks
import UIKit

open class WrappedY<VM: VMP>: BaseViewModel<StackViewExtended>,
   VMWrapper,
   Stateable
{
   public typealias State = StackState

   public lazy var subModel: VM = .init()

   override open func start() {
      axis(.vertical)
      arrangedModels([
         subModel,
      ])
   }
}

open class Wrapped2Y<VM1: VMP, VM2: VMP>: BaseViewModel<StackViewExtended>,
   VMWrapper2,
   Stateable
{
   public typealias State = StackState

   public lazy var model1: VM1 = .init()
   public lazy var model2: VM2 = .init()

   override open func start() {
      axis(.vertical)
      arrangedModels([
         model1,
         model2,
      ])
   }
}

open class Wrapped3Y<VM1: VMP, VM2: VMP, VM3: VMP>: BaseViewModel<StackViewExtended>,
   VMWrapper3,
   Stateable
{
   public typealias State = StackState

   public lazy var model1: VM1 = .init()
   public lazy var model2: VM2 = .init()
   public lazy var model3: VM3 = .init()

   override open func start() {
      axis(.vertical)
      arrangedModels([
         model1,
         model2,
         model3,
      ])
   }
}

open class WrappedX<VM: VMP>: StackModel,
   VMWrapper
{
   public lazy var subModel: VM = .init()

   override open func start() {
      axis(.horizontal)
      arrangedModels([
         subModel,
      ])
   }
}

open class Wrapped2X<VM1: VMP, VM2: VMP>: BaseViewModel<StackViewExtended>,
   VMWrapper2,
   Stateable
{
   public typealias State = StackState

   public lazy var model1: VM1 = .init()
   public lazy var model2: VM2 = .init()

   override open func start() {
      axis(.horizontal)
      arrangedModels([
         model1,
         model2,
      ])
   }
}

open class Wrapped3X<VM1: VMP, VM2: VMP, VM3: VMP>: BaseViewModel<StackViewExtended>,
   VMWrapper3,
   Stateable
{
   public typealias State = StackState

   public lazy var model1: VM1 = .init()
   public lazy var model2: VM2 = .init()
   public lazy var model3: VM3 = .init()

   override open func start() {
      axis(.horizontal)
      arrangedModels([
         model1,
         model2,
         model3,
      ])
   }
}
