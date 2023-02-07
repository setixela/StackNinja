//
//  TextViewModel.swift
//  TeamForce
//
//  Created by Yerzhan Gapurinov on 29.07.2022.
//

import ReactiveWorks
import UIKit

open class TextViewModel: BaseViewModel<TextViewExtended> {
   public var events: EventsStore = .init()

   override open func start() {
      scrollEnabled(false)
      view.on(\.didEditingChanged, self) {
         $0.send(\.didEditingChanged, $1)
      }
   }
}

extension TextViewModel: Stateable3 {
   public typealias State = ViewState
   public typealias State2 = TextViewState
   public typealias State3 = LabelState

   public func applyState(_ state: TextViewState) {
      switch state {
      case let .text(string):
         text(string)
      case let .font(value):
         font(value)
      case let .padding(value):
         padding(value)
      case let .height(value):
         height(value)
      case let .width(value):
         width(value)
      }
   }
}

extension TextViewModel: Eventable {
   public typealias Events = TextViewEvents
}
