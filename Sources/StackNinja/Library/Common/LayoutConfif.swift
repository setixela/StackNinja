//
//  LayoutConfig.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public enum LayoutConfig {
   public static var baseAspectWidth: CGFloat = 360
   public static var sizeAspectCoeficient: CGFloat { UIScreen.main.bounds.width / baseAspectWidth }
}
