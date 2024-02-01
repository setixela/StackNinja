//
//  ViewModelProtocol.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 28.05.2022.
//

import UIKit
import ReactiveWorks

public struct Config {
   public static let isDebugView = false
}

public protocol ViewSetterProtocol: AnyObject {
    associatedtype View: UIView
    
    var view: View { get }
    
    init()
}

public protocol ViewProtocol: ViewSetterProtocol where View == Self {}

public extension ViewProtocol {
    var view: View { self }
}

public protocol ViewModelProtocol: UIViewModel, ViewSetterProtocol {

   var autostartedView: View? { get set }
}

public extension ViewModelProtocol {
   init(_ closure: GenericClosure<Self>) {
      self.init()

      closure(self)
   }
}

public extension UIViewModel where Self: ViewModelProtocol {
   var uiView: UIView {
      let vuew = myView()
      if Config.isDebugView {
         vuew.backgroundColor = .random
      }
      return vuew
   }

   var superview: UIView? {
      view.superview
   }

   var rootSuperview: UIView? {
      view.rootSuperview
   }
}

public protocol ViewModelStorageView: UIView {
   var viewModel: UIViewModel? { get set }
}

extension ViewModelProtocol {
   func myView() -> UIView {
      autoreleased()
   }

   private func autoreleased() -> UIView {
      if isAutoreleaseView, let readyView = autostartedView {
         autostartedView = nil

         return readyView
      }
      view.layoutIfNeeded()

      return view
   }
}

public extension BaseViewModel where View: ViewModelStorageView {
   @discardableResult
   func setNeedsStoreModelInView() -> Self {
      view.viewModel = self
      return self
   }
}

open class BaseViewModel<View: UIView>: NSObject, ViewModelProtocol {
   private weak var weakView: View?

   // will be cleaned after presenting view
   public var autostartedView: View?
   public var isAutoreleaseView = false

   public var view: View {
      if let view = weakView {
         return view
      } else {
         let view = View(frame: .zero)
         weakView = view
         autostartedView = view
         start()

         return view
      }
   }

   deinit {
      autostartedView = nil
   }

   override public required init() {
      super.init()
   }

   public init(isAutoreleaseView: Bool) {
      super.init()
      self.isAutoreleaseView = isAutoreleaseView
   }

   public init(view: View) {
      super.init()

      autostartedView = view
      weakView = view
   }

   open func start() {}

   public func setupView(_ closure: GenericClosure<View>) {
      closure(view)
   }
}

public extension UIViewModel where Self: Stateable {
   init(state: State) {
      self.init(state)
   }
}

private extension UIColor {
   static var random: UIColor {
      .init(hue: .random(in: 0 ... 1), saturation: 0.33, brightness: 1, alpha: 0.4)
   }
}
