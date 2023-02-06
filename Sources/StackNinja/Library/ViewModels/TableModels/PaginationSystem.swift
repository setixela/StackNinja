//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 06.02.2023.
//

import Foundation
import ReactiveWorks

public struct Pagination {
   public let offset: Int
   public let limit: Int
}

public final class PaginationSystem {
   
   private lazy var retainer = Retainer()
   
   public  var isReady: Bool { !isFinished && !isPaginationInProgress }
   
   private var isPaginationInProgress = false
   private var isFinished = false
   private var currentOffset = 0
   
   private let startOffset: Int
   private let pageSize: Int 
   
   public init(pageSize: Int, startOffset: Int) {
      self.pageSize = pageSize
      self.startOffset = startOffset
      self.currentOffset = startOffset
   }
   
   public func getCurrentPage() -> Pagination {
      isPaginationInProgress = true
      
      return Pagination(offset: currentOffset, limit: pageSize)
   }
   
   public func pageLoaded() {
      isPaginationInProgress = false
      currentOffset += 1
   }
   
   public func pageLoadError() {
      isPaginationInProgress = false
   }
   
   public func finished() {
      isFinished = true
   }
   
   public func reInit() {
      isFinished = false
      currentOffset = startOffset
   }
}

public extension PaginationSystem {
   func paginationForWork<T>(_ loadWork: In<Pagination>.Out<[T]>?) -> Out<[T]> {
      let work = Out<[T]> { [weak self] work in
         guard let self, self.isReady else { work.fail(); return }
         
         let pagination = self.getCurrentPage()
         
         loadWork?
            .doAsync(pagination)
            .onSuccess {
               if $0.isEmpty {
                  self.finished()
               } else {
                  self.pageLoaded()
               }
               
               work.success($0)
            }
            .onFail {
               self.pageLoadError()
               
               work.fail()
            }
      }
      return work.retainBy(retainer)
   }
}
