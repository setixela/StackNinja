//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import AlamofireImage
import ReactiveWorks
import UIKit

public final class ButtonExtended: UIButton, AlamoLoader, Tappable, LoadableView {
   public typealias Events = ButtonEvents

   public var events: EventsStore = .init()

   var isVertical = false

   public var activityModel: UIViewModel?

   override init(frame: CGRect) {
      super.init(frame: frame)

      imageView?.contentMode = .scaleAspectFit
   }

   public override func layoutSubviews() {
      super.layoutSubviews()

      if isVertical {
         setButtonVertical()
      }
   }

   @available(*, unavailable)
   required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   @objc public override func didTap() {
      send(\.didTap)
   }

   public override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
      super.setBackgroundImage(image, for: state)

      let first = subviews.first
      first?.contentMode = .scaleAspectFill
   }

   private func setButtonVertical() {
      let titleSize = titleLabel?.frame.size ?? .zero
      let imageSize = imageView?.frame.size ?? .zero
      let spacing: CGFloat = 6.0
      imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
      titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
   }
}
