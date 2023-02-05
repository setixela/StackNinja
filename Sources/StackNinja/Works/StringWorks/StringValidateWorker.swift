//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks

public final class StringValidateWorker: BaseStringValidator, WorkerProtocol {
   
   public func doAsync(work: Work<String, String>) {
      let text = work.unsafeInput

      if validate(text) {
         work.success(result: text)
      } else {
         work.fail(text)
      }
   }
}
