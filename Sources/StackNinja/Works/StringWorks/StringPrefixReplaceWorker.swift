//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks

public final class FirstCharReplaceWorker: WorkerProtocol {
   
   let firstChar: String
   let replaceChar: String

   public init(if firstChar: String, replaceTo: String) {
      self.firstChar = firstChar
      replaceChar = replaceTo
   }

   public func doAsync(work: Work<String, String>) {
      var text = work.unsafeInput
      if text.hasPrefix(firstChar) {
         text = text.replacingCharacters(in: ...text.startIndex, with: replaceChar)
      }
      work.success(text)
   }
}
