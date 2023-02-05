//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 12.08.2022.
//

import ReactiveWorks

public protocol VMWrapper: AnyObject, InitProtocol {
   associatedtype VM: VMP

   var subModel: VM { get set }
}

public extension VMWrapper where Self: VMP {
   init(_ wrapped: VM) {
      self.init()

      subModel = wrapped
   }
}

public protocol VMWrapper2: AnyObject, InitProtocol {
   associatedtype VM1: VMP
   associatedtype VM2: VMP

   var model1: VM1 { get set }
   var model2: VM2 { get set }
}

public extension VMWrapper2 where Self: VMP {
   init(_ wrapped1: VM1, _ wrapped2: VM2) {
      self.init()

      model1 = wrapped1
      model2 = wrapped2
   }
}

public protocol VMWrapper3: AnyObject, InitProtocol {
   associatedtype VM1: VMP
   associatedtype VM2: VMP
   associatedtype VM3: VMP

   var model1: VM1 { get set }
   var model2: VM2 { get set }
   var model3: VM3 { get set }
}

public extension VMWrapper3 where Self: VMP {
   init(_ wrapped1: VM1, _ wrapped2: VM2, _ wrapped3: VM3) {
      self.init()

      model1 = wrapped1
      model2 = wrapped2
      model3 = wrapped3
   }
}
