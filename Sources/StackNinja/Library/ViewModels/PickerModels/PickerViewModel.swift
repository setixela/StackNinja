//
//  PickerViewModel.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 09.07.2022.
//

import ReactiveWorks
import UIKit

struct PickerViewEvent: InitProtocol {
   var didSelectRow: Int?
}

enum PickerViewState {
   case items([String])
}

final class PickerViewModel: BaseViewModel<UIPickerView> {
   typealias Events = PickerViewEvent

   var events = EventsStore()

   private var items: [String] = []
   var selectedItem: String?
   var textField = TextFieldModel()
   override func start() {
      view.dataSource = self
      view.delegate = self
      textField.view.inputView = view
      dismissPickerView()
   }

   func attachToTextField(textField: TextFieldModel) {
      self.textField = textField
   }

   func dismissPickerView() {
      let toolBar = UIToolbar()
      toolBar.sizeToFit()

      let button = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(action))
      toolBar.setItems([button], animated: true)
      toolBar.isUserInteractionEnabled = true
      textField.view.inputAccessoryView = toolBar
   }

   @objc func action() {
      textField.view.endEditing(true)
   }
}

extension PickerViewModel: Eventable {}

extension PickerViewModel: UIPickerViewDelegate {
   func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
      items[row]
   }

   func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
      selectedItem = items[row]
      textField.view.text = selectedItem
      send(\.didSelectRow, row)
   }
}

extension PickerViewModel: UIPickerViewDataSource {
   func numberOfComponents(in _: UIPickerView) -> Int {
      1
   }

   func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
      items.count
   }
}

extension PickerViewModel: Stateable2 {
   func applyState(_ state: PickerViewState) {
      switch state {
      case let .items(array):
         items = array
         view.reloadAllComponents()
      }
   }

   typealias State = ViewState
   typealias State2 = PickerViewState
}
