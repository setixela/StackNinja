//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 16.02.2023.
//

import ReactiveWorks

public class TextCachableWork: InOut<String> {
   private var key: String?
   private let cache: StaticTextCacheProtocol.Type

   public func setKey(_ key: String) {
      self.key = key
      if let value = cache.valueForKey(key) {
         doAsync(value)
      }
   }

   public func clearCache() {
      guard let key else { return }
      cache.clearCacheForKey(key)
   }

   public init(cache: StaticTextCacheProtocol.Type, key: String? = nil) {
      
      self.cache = cache
      self.key = key
      
      super.init()

      closure = { [weak self] work in
         let value = work.in

         guard let key = self?.key else { work.success(value); return }

         self?.cache.updateValueForKey(key, value: value)
         work.success(value)
      }

      defer {
         if let key, let value = cache.valueForKey(key) {
            doAsync(value)
         }
      }
   }
}
