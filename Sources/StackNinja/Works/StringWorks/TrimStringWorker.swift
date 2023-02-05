//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks

public final class TrimStringWorker: WorkerProtocol {
   private let maxChars: Int
   
   public init(maxChars: Int) {
      self.maxChars = maxChars
   }

   public func doAsync(work: Work<String, String>) {
      let text = work.unsafeInput

      work.success(result: text.count > maxChars ? String(text.prefix(maxChars)) : text)
   }
}
