//
//  Router.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 03.06.2022.
//

import UIKit

public enum NavType {
   case push
   case presentInitial
   case presentModally(UIModalPresentationStyle)
   case presentModallyOnPresented(UIModalPresentationStyle)
}
