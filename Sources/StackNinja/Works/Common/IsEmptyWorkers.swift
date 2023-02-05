//
//  EmptyChecker.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 03.08.2022.
//

import Foundation
import ReactiveWorks

public final class IsEmptyToBool<T: Collection>: WorkerProtocol {
   public  typealias In = T
   public  typealias Out = Bool

   public init() {}

   public func doAsync(work: Wrk) {
      if work.unsafeInput.isEmpty {
         work.success(result: true)
      } else {
         work.success(result: false)
      }
   }
}

public final class IsNotEmptyToBool<T: Collection>: WorkerProtocol {
   public  typealias In = T
   public  typealias Out = Bool

   public init() {}

   public func doAsync(work: Wrk) {
      if !work.unsafeInput.isEmpty {
         work.success(result: true)
      } else {
         work.success(result: false)
      }
   }
}

public struct IsEmpty<T: Collection>: UseCaseProtocol {
   public  typealias In = T
   public  typealias Out = T
   
   public init() {}

   public var work: Work<In, Out> {
      .init {
         if $0.unsafeInput.isEmpty {
            $0.success(result: $0.unsafeInput)
         } else {
            $0.fail($0.unsafeInput)
         }
      }
   }
}

public struct IsNotEmpty<T: Collection>: UseCaseProtocol {
   public  typealias In = T
   public  typealias Out = T
   
   public init() {}

   public var work: Work<In, Out> {
      .init {
         if !$0.unsafeInput.isEmpty {
            $0.success(result: $0.unsafeInput)
         } else {
            $0.fail($0.unsafeInput)
         }
      }
   }
}
