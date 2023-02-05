//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import Foundation

public extension String {
   var isNumber: Bool {
      !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
   }
}

// MARK: - String Validator

public protocol StringValidator {
   var isEmptyValid: Bool { get }
   var minSymbols: Int { get }
   var maxSymbols: Int { get }
   init(isEmptyValid: Bool, minSymbols: Int, maxSymbols: Int)
   func validate(_ string: String) -> Bool
}

public class BaseStringValidator {
   let isEmptyValid: Bool
   let minSymbols: Int
   let maxSymbols: Int
   
   public  init(isEmptyValid: Bool, minSymbols: Int, maxSymbols: Int = 4096) {
      self.isEmptyValid = isEmptyValid
      self.minSymbols = minSymbols
      self.maxSymbols = maxSymbols
   }
   
   public func validate(_ string: String) -> Bool {
      if string.isEmpty, isEmptyValid { return true }
      if string.count >= minSymbols, string.count <= maxSymbols {
         return true
      }
      return false
   }
}
