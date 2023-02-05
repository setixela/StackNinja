//
//  SceneWorks.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 11.08.2022.
//

import ReactiveWorks

// MARK: - Temp single type storage

public protocol StorageProtocol: InitProtocol {
   associatedtype Store: InitAnyObject

   static var store: Store { get }
}

// TODO: - need to change conception

enum UnsafeTemper {
   private static var storage: [String: [InitAnyObject]] = [:]

   static func initStore(for type: InitAnyObject.Type) {
      let key = String(reflecting: type)
      let new = type.init()

      if var arr = storage[key] {
         arr.append(new)
         storage[key] = arr
      } else {
         storage[key] = [new]
      }
   }

   static func store<T: InitAnyObject>(for type: T.Type) -> T {
      let key = String(reflecting: type)

      guard let value = storage[key]?.last as? T else {
         return T()
      }

      return value
   }

   static func clearStore(for type: InitAnyObject.Type) {
      let key = String(reflecting: type)

      guard var arr = storage[key] else { return }
      
      arr.removeLast()
      if arr.isEmpty {
         storage[key] = nil
      } else {
         storage[key] = arr
      }
   }
}
