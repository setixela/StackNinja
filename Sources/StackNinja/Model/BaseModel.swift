//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import Foundation

open class BaseModel: NSObject, ModelProtocol {
   open func start() {
      
   }
   
   public override required init() {
      super.init()
      start()
   }
}
