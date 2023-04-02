//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import Alamofire
import AlamofireImage
import ReactiveWorks
import UIKit

public protocol AlamoLoader {}

public extension AlamoLoader {
   func loadImage(_ urlStr: String?, result: @escaping (UIImage?) -> Void) {
      guard
         let str = urlStr
      else { result(nil); return }

      AF.request(str).responseImage {
         if case let .success(image) = $0.result {
            result(image)
            return
         }
         result(nil)
      }
   }
}

public final class PaddingImageView: UIImageView,
   Marginable,
   AlamoLoader,
   Tappable,
   LoadableView,
   ViewModelStorageView,
   Squircle
{
   public var viewModel: UIViewModel?

   public var padding: UIEdgeInsets = .init()

   public var events: EventsStore = .init()

   public var imageTintColor: UIColor?

   public var activityModel: UIViewModel?

   override public var image: UIImage? {
      set {
         if let imageTintColor {
            super.image = newValue?.withTintColor(imageTintColor)
         } else {
            super.image = newValue
         }
      }
      get {
         super.image
      }
   }

   override public var alignmentRectInsets: UIEdgeInsets {
      .init(top: -padding.top,
            left: -padding.left,
            bottom: -padding.bottom,
            right: -padding.right)
   }

   override public func layoutSubviews() {
      super.layoutSubviews()

      send(\.didLayout)
   }
}

extension PaddingImageView: Eventable {
   public typealias Events = ButtonEvents
}

public extension UIImage {
   func withInset(_ insets: UIEdgeInsets) -> UIImage {
      let cgSize = CGSize(width: size.width + insets.left * scale + insets.right * scale,
                          height: size.height + insets.top * scale + insets.bottom * scale)

      UIGraphicsBeginImageContextWithOptions(cgSize, false, scale)
      defer { UIGraphicsEndImageContext() }

      let origin = CGPoint(x: insets.left * scale, y: insets.top * scale)
      draw(at: origin)

      return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(renderingMode) ?? self
   }
}
