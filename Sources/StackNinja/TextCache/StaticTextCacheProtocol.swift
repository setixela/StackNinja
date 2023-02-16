//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 16.02.2023.
//

public protocol StaticTextCacheProtocol {
   static func updateValueForKey(_ key: String, value: String)
   static func valueForKey(_ key: String) -> String?
   static func clearCacheForKey(_ key: String)
}
