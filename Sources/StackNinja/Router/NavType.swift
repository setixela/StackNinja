//
//  Router.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 03.06.2022.
//

import UIKit

public enum NavType: RawRepresentable {
   public init?(rawValue: String) {
      nil
   }
   
   public var rawValue: String {
      switch self {
      case .push:
         return "push"
      case .presentInitial:
         return "presentInitial"
      case .presentModally:
         return "presentModally"
      case .bottomScheet:
         return "bottomScheet"
      case .presentModallyOnPresented:
         return "presentModallyOnPresented"
      }
   }

   public typealias RawValue = String

   case push
   case presentInitial
   case presentModally(UIModalPresentationStyle)
   case bottomScheet
   case presentModallyOnPresented(UIModalPresentationStyle)
}
