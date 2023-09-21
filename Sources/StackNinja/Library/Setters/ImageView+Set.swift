//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import Alamofire
import AlamofireImage

public extension ViewSetterProtocol where View: PaddingImageView {
   @discardableResult func image(_ value: UIImage, color: UIColor? = nil) -> Self {
      if let color {
         view.imageTintColor = color
      }
      view.image = value
      view.layer.masksToBounds = true
      return self
   }
   
   @discardableResult func image(
      _ value: UIImage,
      color: UIColor? = nil,
      duration: CGFloat,
      transitionType: CATransitionType = .fade
   ) -> Self {
      if let color {
         view.imageTintColor = color
      }
      let transition = CATransition()
      transition.duration = duration
      transition.type = transitionType
      view.layer.add(transition, forKey: nil)
      
      view.image = value
      view.layer.masksToBounds = true
      return self
   }
   
    @discardableResult func textImage(_ value: String, backColor: UIColor, textColor: UIColor = .white) -> Self {
      DispatchQueue.global(qos: .background).async { [weak self] in
         let image = value.drawImage(backColor: backColor, textColor: textColor)
         DispatchQueue.main.async {
            self?.view.image = image
            self?.view.backgroundColor = backColor
            self?.view.layer.masksToBounds = true
         }
      }
      return self
   }
   
   @discardableResult func contentMode(_ value: UIView.ContentMode) -> Self {
      view.contentMode = value
      return self
   }
   
   @discardableResult func padding(_ value: UIEdgeInsets) -> Self {
      view.padding = value
      return self
   }
   
   @discardableResult func imageTintColor(_ value: UIColor) -> Self {
      view.imageTintColor = value
      view.image = view.image
      view.tintColor = value
      return self
   }
   
   @discardableResult func cornerRadius(_ value: CGFloat) -> Self {
      view.layer.cornerRadius = value
      view.clipsToBounds = true
      view.layer.masksToBounds = true
      return self
   }
   
   @discardableResult func url(_ value: String?,
                               placeHolder: UIImage? = nil,
                               transition: UIImageView.ImageTransition = .noTransition,
                               closure: ((Self?, UIImage?) -> Void)? = nil) -> Self
   {
      view.layer.masksToBounds = true
      
      guard let url = URL(string: value ?? "") else {
         view.image = placeHolder ?? view.image
         return self
      }
      
      view.af.setImage(
         withURL: url,
         placeholderImage: placeHolder,
         imageTransition: transition
      ) {
         weak var slf = self
         
         switch $0.result {
         case let .success(image):
            closure?(slf, image)
         case .failure:
            closure?(slf, nil)
         }
      }
      
      return self
   }
    
   @discardableResult func indirectUrl(
      _ value: String?,
      placeHolder: UIImage? = nil,
      transition: UIImageView.ImageTransition = .noTransition,
      closure: ((Self?, UIImage?) -> Void)? = nil
   ) -> Self {
      view.layer.masksToBounds = true
      
      guard let url = URL(string: value ?? "") else {
         view.image = placeHolder ?? view.image
         return self
      }
      
      view.image = placeHolder
      
      AF
         .request(url)
         .responseImage { [weak self] response in
            switch response.result {
            case let .success(image):
               self?.view.af.run(transition, with: image)
               closure?(self, image)
            case .failure:
               closure?(self, nil)
            }
         }
      
      return self
   }
}

public extension String {
    func drawImage(backColor: UIColor, textColor: UIColor = .white) -> UIImage {
      let text = self
      let attributes = [
         NSAttributedString.Key.foregroundColor: textColor,
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
         NSAttributedString.Key.backgroundColor: backColor
      ]
      let textSize = text.size(withAttributes: attributes)
      let newSize = CGSize(width: 40, height: 40)
      
      let renderer = UIGraphicsImageRenderer(size: newSize)
      let image = renderer.image(actions: { _ in
         text.draw(at: CGPoint(x: newSize.width / 2 - textSize.width / 2,
                               y: newSize.height / 2 - textSize.height / 2),
                   withAttributes: attributes)
      })
      return image
   }
}
