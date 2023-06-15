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

public struct PaginationWithRequest<Request> {
   public let offset: Int
   public let limit: Int
   public let request: Request
}

public final class PaginationSystem {
   private lazy var retainer = Retainer()

   public var isReady: Bool { !isFinished && !isPaginationInProgress }

   private var isPaginationInProgress = false
   private var isFinished = false
   private var currentOffset = 0

   private let startOffset: Int
   private let pageSize: Int

   public init(pageSize: Int, startOffset: Int) {
      self.pageSize = pageSize
      self.startOffset = startOffset
      currentOffset = startOffset
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
      isPaginationInProgress = false
   }

   public func reInit() {
      isFinished = false
      isPaginationInProgress = false
      currentOffset = startOffset
   }
}

public extension PaginationSystem {
   func paginationForWork<T>(_ loadWork: In<Pagination>.Out<[T]>?) -> Out<[T]> {
      let work = Out<[T]> { [weak self] work in
         guard let self, self.isReady else { work.success([]); return }

         let pagination = self.getCurrentPage()

         loadWork?
            .doAsync(pagination)
            .onSuccess {
               if $0.isEmpty {
                  self.finished()
                  work.success([])
               } else {
                  self.pageLoaded()
                  work.success($0)
               }
            }
            .onFail {
               self.pageLoadError()
               work.fail()
            }
      }

      return work.retainBy(retainer)
   }

   func paginationForWork<T, R>(
      _ loadWork: In<PaginationWithRequest<R>>.Out<[T]>?,
      withRequest request: R
   ) -> Out<[T]> {
      let work = Out<[T]> { [weak self] work in
         guard let self, self.isReady else { work.success([]); return }

         let pagination = self.getCurrentPage()
         let withRequest = PaginationWithRequest(
            offset: pagination.offset,
            limit: pagination.limit,
            request: request
         )

         loadWork?
            .doAsync(withRequest)
            .onSuccess {
               if $0.isEmpty {
                  self.finished()
                  work.success([])
               } else {
                  self.pageLoaded()
                  work.success($0)
               }
            }
            .onFail {
               self.pageLoadError()
               work.fail()
            }
      }

      return work.retainBy(retainer)
   }
}
