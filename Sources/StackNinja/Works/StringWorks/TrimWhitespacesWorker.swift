//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks

public final class TrimWhitespacesWorker: WorkerProtocol {
   public init() {}
   
   public func doAsync(work: Work<String, String>) {
      let text = work.unsafeInput

      work.success(result: removeLeadingAndTrailingSpaces(string: text))
   }

   private func removeLeadingAndTrailingSpaces(string: String) -> String {
      string.trimmingCharacters(in: .whitespacesAndNewlines)
   }
}
