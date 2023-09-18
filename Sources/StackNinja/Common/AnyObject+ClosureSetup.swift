//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 21.01.2023.
//

import Foundation

public protocol ClosureSetup: AnyObject {}

public extension ClosureSetup {

   @discardableResult
   func setup(_ closure: (Self) -> Void) -> Self {
      closure(self)
      return self
   }
}

extension BaseModel: ClosureSetup {
    convenience init(_ closure: (Self) -> Void) {
        self.init()
        
        closure(self)
    }
}

extension BaseViewModel: ClosureSetup {
   convenience init(_ closure: (Self) -> Void) {
      self.init()

      closure(self)
   }
}
