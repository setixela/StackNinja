//
//  BarButtonModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 01.07.2022.
//

import ReactiveWorks
import UIKit

public struct BarButtonEvent: InitProtocol {
   public init() {}

   public var initWithImage: UIImage?
   public var initiated: UIBarButtonItem?
   public var didTap: Void?
}

public final class BarButtonModel: BaseModel, Eventable {
   public typealias Events = BarButtonEvent
   public var events = [Int: LambdaProtocol?]()

   override public func start() {
      on(\.initWithImage) { [weak self] image in
         self?.startWithImage(image)
      }
   }

   private func startWithImage(_ image: UIImage) {
      let menuItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTap))
      send(\.initiated, menuItem)
   }

   @objc func didTap() {
      send(\.didTap)
   }
}
