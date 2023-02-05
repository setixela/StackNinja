//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import ReactiveWorks
import UIKit

public final class PaddingLabel: UILabel, Marginable, Tappable {
   public var events: EventsStore = .init()

   public var padding: UIEdgeInsets = .init()

   public lazy var paragraphStyle: NSMutableParagraphStyle = .init()

   override public func draw(_ rect: CGRect) {
      drawText(in: rect.inset(by: padding))
   }

   override public var intrinsicContentSize: CGSize {
      guard let text, let font else { return super.intrinsicContentSize }

      var contentSize = super.intrinsicContentSize
      var textWidth: CGFloat = contentSize.width
      var insetsHeight: CGFloat = 0.0
      var insetsWidth: CGFloat = 0.0

      insetsWidth += padding.left + padding.right
      insetsHeight += padding.top + padding.bottom

      textWidth += insetsWidth

      let maxHeight =
         font.lineHeight * (numberOfLines == 0 ? CGFloat.greatestFiniteMagnitude : CGFloat(numberOfLines + 1))

      var attribs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
                                                    .paragraphStyle: paragraphStyle]

      if let attributedText,
         !attributedText.string.isEmpty,
         let kern = attributedText.attribute(.kern, at: 0, effectiveRange: nil)
      {
         attribs[.kern] = kern
      }

      let newSize = text.boundingRect(
         with: CGSize(width: textWidth, height: maxHeight),
         options: [.usesLineFragmentOrigin],
         attributes: attribs,
         context: nil
      )

      contentSize.height = ceil(newSize.size.height) + insetsHeight
      contentSize.width = ceil(newSize.size.width) + insetsWidth

      return contentSize
   }

   public func makePartsClickable(substring1: String?, substring2: String?) {
      isUserInteractionEnabled = true
      let tapGesture = CustomTap(target: self,
                                 action: #selector(tappedOnLabel(gesture:)))
      tapGesture.user1 = substring1
      tapGesture.user2 = substring2
      addGestureRecognizer(tapGesture)
      lineBreakMode = .byWordWrapping
   }

   @objc public func tappedOnLabel(gesture: CustomTap) {
      guard let text = text else { return }

      let firstRange = (text as NSString).range(of: gesture.user1.string)
      let secondRange = (text as NSString).range(of: gesture.user2.string)
      print("first range \(firstRange)")
      print("second range \(secondRange)")
      if gesture.didTapAttributedTextInLabel(label: self, inRange: firstRange) {
         print("firstRange tapped")
         send(\.didSelect, gesture.user1.string)
         send(\.didSelectRangeIndex, 0)
      } else if gesture.didTapAttributedTextInLabel(label: self, inRange: secondRange) {
         print("secondRange tapped")
         send(\.didSelect, gesture.user2.string)
         send(\.didSelectRangeIndex, 1)
      }
   }
}

public class CustomTap: UITapGestureRecognizer {
   public var user1: String?
   public var user2: String?
}

public extension String {
   func colored(_ color: UIColor) -> NSAttributedString {
      let attrStr = NSAttributedString(string: self, attributes: [.foregroundColor: color])
      return attrStr
   }
}

public extension UITapGestureRecognizer {
   func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
      guard let attributedText = label.attributedText else { return false }
      
      let mutableStr = NSMutableAttributedString(attributedString: attributedText)
      mutableStr.addAttributes([NSAttributedString.Key.font: label.font!], range: NSRange(location: 0, length: attributedText.length))
      
      // If the label have text alignment. Delete this code if label have a default (left) aligment. Possible to add the attribute in previous adding.
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
      
      // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
      let layoutManager = NSLayoutManager()
      let textContainer = NSTextContainer(size: CGSize.zero)
      let textStorage = NSTextStorage(attributedString: mutableStr)
      
      // Configure layoutManager and textStorage
      layoutManager.addTextContainer(textContainer)
      textStorage.addLayoutManager(layoutManager)
      
      // Configure textContainer
      textContainer.lineFragmentPadding = 0.0
      textContainer.lineBreakMode = label.lineBreakMode
      textContainer.maximumNumberOfLines = label.numberOfLines
      let labelSize = label.bounds.size
      textContainer.size = labelSize
      
      // Find the tapped character location and compare it to the specified range
      let locationOfTouchInLabel = location(in: label)
      let textBoundingBox = layoutManager.usedRect(for: textContainer)
      let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                        y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
      let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                   y: locationOfTouchInLabel.y - textContainerOffset.y)
      let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
      return NSLocationInRange(indexOfCharacter, targetRange)
   }
}
