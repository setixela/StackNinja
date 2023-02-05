//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 27.10.2022.
//

import ReactiveWorks

public typealias InitAnyObject = AnyObject & InitProtocol

public protocol WorksProtocol: AnyObject {
   var retainer: Retainer { get }
}

public protocol StoringWorksProtocol: WorksProtocol, StorageProtocol {}

open class BaseWorks<Store: InitAnyObject, Asset: AssetRoot>: WorksProtocol, StorageProtocol {
   public lazy var retainer = Retainer()

   public required init() {
      UnsafeTemper.initStore(for: Store.self)
   }

   deinit {
      UnsafeTemper.clearStore(for: Store.self)
   }

   public static var store: Store {
      UnsafeTemper.store(for: Store.self)
   }
}
