//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public final class TextViewExtended: UITextView, UITextViewDelegate, LoadableView {
   public var events: EventsStore = .init()

   public var activityModel: UIViewModel?

   var placeholder: String? {
      didSet {
         text = placeholder
      }
   }

   var placeHolderColor: UIColor = .gray
   var baseTextColor: UIColor?

   private var isPlaceholded: Bool { text == placeholder }

   override init(frame: CGRect, textContainer: NSTextContainer?) {
      super.init(frame: frame, textContainer: textContainer)

      delegate = self
   }

   @available(*, unavailable)
   required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   public func textViewDidChange(_ textView: UITextView) {
      send(\.didEditingChanged, textView.text)
   }

   override public func layoutSubviews() {
      super.layoutSubviews()

      if isPlaceholded {
         textColor = placeHolderColor
      } else {
         textColor = baseTextColor
      }
   }

   public func textViewDidBeginEditing(_: UITextView) {
      if isPlaceholded {
         textColor = baseTextColor
         text = ""
      }
   }

   public func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text == nil || textView.text.isEmpty {
         textView.text = placeholder
         textView.textColor = placeHolderColor
      }
   }
}

extension TextViewExtended: Eventable {
   public typealias Events = TextViewEvents
}

public struct TextViewEvents: InitProtocol {
   public init() {}

   public var didEditingChanged: String?
}
