//
//  TextFieldModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 24.06.2022.
//

import Anchorage
import ReactiveWorks
import UIKit

public struct TextFieldEvents: InitProtocol {
   public init() {}

   public var didEditingChanged: String?
   public var didTap: String?
   public var didBeginEditing: String?
   public var didEndEditing: String?
   public var textFieldShouldClear: Void?
   public var textFieldShouldReturn: String?
}


open class WorkableTextFieldModel: BaseViewModel<PaddingTextField>, Stateable3 {
   public typealias State = TextFieldState
   public typealias State2 = ViewState
   public typealias State3 = LabelState
}

open class TextFieldModel: BaseViewModel<PaddingTextField>,
   Stateable3,
   Eventable,
   UITextFieldDelegate
{
   public typealias Events = TextFieldEvents

   public var events = EventsStore()

   override open func start() {
      set(.clearButtonMode(.whileEditing))
      view.delegate = self
      view.addTarget(self, action: #selector(changValue), for: .editingChanged)
      view.addTarget(self, action: #selector(didEditingBegin), for: .editingDidBegin)
      view.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
   }

   @objc func changValue() {
      guard let text = view.text else { return }

      send(\.didEditingChanged, text)
   }

   @objc func didEditingBegin() {
      guard let text = view.text else { return }
      send(\.didBeginEditing, text)
      print("Did tap textfield")
   }

   @objc func didEndEditing() {
      send(\.didEndEditing, view.text.string)
   }

   public func textFieldDidBeginEditing(_: UITextField) {
      // view.becomeFirstResponder()
   }

   public func textField(_: UITextField, shouldChangeCharactersIn _: NSRange, replacementString string: String) -> Bool {
      guard view.isOnlyDigitsMode else { return true }

      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)
      return allowedCharacters.isSuperset(of: characterSet)
   }
   
   public func textFieldShouldClear(_ textField: UITextField) -> Bool {
      send(\.textFieldShouldClear)
      return true
   }
   
   public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      send(\.textFieldShouldReturn, view.text.string)
      return true
   }
}

public extension TextFieldModel {
   typealias State = TextFieldState
   typealias State2 = ViewState
   typealias State3 = LabelState
}
