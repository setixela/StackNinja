//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import Foundation

public final class PhoneValidateWorker: BaseStringValidator, WorkerProtocol {
   
   private let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
   private lazy var phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)

   public func doAsync(work: Work<String, String>) {
      let text = work.unsafeInput

      if validate(text) {
         work.success(result: text)
      } else {
         work.fail()
      }
   }

   override public func validate(_ string: String) -> Bool {
      guard super.validate(string) else { return false }

      if string.isEmpty, isEmptyValid { return true }

      return phoneTest.evaluate(with: string)
   }
}
