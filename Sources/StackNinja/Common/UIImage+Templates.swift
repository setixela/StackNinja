//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 28.03.2023.
//

import UIKit

public extension UIImage {
   var alwaysTemplate: UIImage {
      withRenderingMode(.alwaysTemplate)
   }

   var alwaysOriginal: UIImage {
      withRenderingMode(.alwaysOriginal)
   }

   func oriented(_ orientation: UIImage.Orientation) -> UIImage {
      .init(cgImage: self.cgImage!, scale: self.scale, orientation: orientation)
   }
}
