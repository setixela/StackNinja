//
//  File.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 24.06.2022.
//

import ReactiveWorks
import UIKit

public enum TapGestureState {
   case tapGesturing
}

open class ImageViewModel: BaseViewModel<PaddingImageView>, Eventable {
   public typealias Events = ButtonEvents
   public var events = [Int: LambdaProtocol?]()

   override open func start() {
      contentMode(.scaleAspectFit)
   }

   @objc func didTap() {
      send(\.didTap)
      print("Did tap")

      animateTap(uiView: uiView)
   }
}

extension ImageViewModel: Stateable3, ButtonTapAnimator {
   public typealias State = ViewState
   public typealias State2 = ImageViewState

   public func applyState(_ state: TapGestureState) {
      switch state {
      case .tapGesturing:
         makeTappable()
      }
   }
}

public extension ImageViewModel {
   @discardableResult
   func makeTappable() -> Self {
      view
         .startTapGestureRecognize()
         .on(\.didTap, self) {
            $0.send(\.didTap)
         }
      return self
   }
}
