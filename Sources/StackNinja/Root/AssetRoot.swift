//
//  AssetRoot.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 04.08.2022.
//

import ReactiveWorks

public protocol AssetRoot {
   associatedtype Scene: InitProtocol
   associatedtype Service: InitProtocol
   associatedtype Design: DesignRoot

   associatedtype Router: NavigateProtocol

   typealias Asset = Self
   typealias Text = Design.Text

   static var router: Router? { get set }
}

public extension AssetRoot {
   static var scene: Scene { .init() }
   static var service: Service { .init() }
   static var design: Design { .init() }

   static var text: Text { Design.text }
}

//

public protocol DesignRoot: InitProtocol {
   associatedtype Text: InitProtocol
   associatedtype Color: InitProtocol
   associatedtype Icon: InitProtocol
   associatedtype Font: InitProtocol
   associatedtype Label: InitProtocol
   associatedtype Button: InitProtocol

   associatedtype State: InitProtocol

   associatedtype Params: InitProtocol
   //
   associatedtype Model: InitProtocol
}

public extension DesignRoot {
   static var text: Text { .init() }
   static var color: Color { .init() }
   static var icon: Icon { .init() }
   static var font: Font { .init() }
   static var label: Label { .init() }
   static var button: Button { .init() }

   static var state: State { .init() }

   static var params: Params { .init() }
   //
   static var model: Model { .init() }
}
