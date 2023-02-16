//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 16.02.2023.
//

import ReactiveWorks

public struct StaticTextCache: StaticTextCacheProtocol {
   private static var cache: [String: String] = [:]
   
   public  static func updateValueForKey(_ key: String, value: String) {
      cache[key] = value == "" ? nil : value
   }
   
   public  static func valueForKey(_ key: String) -> String? {
      cache[key]
   }
   
   public  static func clearCacheForKey(_ key: String) {
      cache[key] = nil
   }
}
