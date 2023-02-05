//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

public protocol Assetable {
   associatedtype Asset: AssetRoot
   
   typealias Design = Asset.Design
   typealias Service = Asset.Service
   typealias Scene = Asset.Scene
   typealias Text = Asset.Design.Text
}
