//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import Foundation

public final class EmailValidateWorker: BaseStringValidator, WorkerProtocol {

   private let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
   private lazy var emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
   
   public func doAsync(work: Work<String, String>) {
      let text = work.unsafeInput
      
      if validate(text) {
         work.success(result: text)
      } else {
         work.fail()
      }
   }
   
   public override func validate(_ string: String) -> Bool {
      guard super.validate(string) else { return false }
      if string.isEmpty, isEmptyValid { return true }
      return emailPredicate.evaluate(with: string)
   }
}
