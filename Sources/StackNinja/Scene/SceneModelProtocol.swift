//
//  Scene.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 28.05.2022.
//

import ReactiveWorks
import UIKit

public protocol SceneModelProtocol: ModelProtocol {
   func makeVC() -> UIViewController
   func makeMainView() -> UIView
   func setInput(_ value: Any?)
   func dismiss(animated: Bool)
}

public protocol SceneInputProtocol: AnyObject {
   associatedtype Input
}

public protocol SceneOutputProtocol: AnyObject {
   associatedtype Output: Any
   var finishWork: Work<Void, Output>? { get set }
}

open class BaseScene<In, Out>: NSObject, SceneInputProtocol, SceneModelProtocol, SceneOutputProtocol {
   open func makeVC() -> UIViewController {
      fatalError()
   }

   open func makeMainView() -> UIView {
      fatalError()
   }

   open func setInput(_: Any?) {
      fatalError()
   }

   open func dismiss(animated _: Bool) {
      fatalError()
   }

   public var finishWork: Work<Void, Out>?

   open func start() {}

   public typealias Input = In
   public typealias Output = Out
}

public protocol SceneModel: SceneModelProtocol, SceneInputProtocol {
   associatedtype VCModel: VCModelProtocol
   associatedtype MainViewModel: ViewModelProtocol

   var vcModel: VCModel? { get set }
   var mainVM: MainViewModel { get }
}

public struct SceneEvent<Input>: InitProtocol {
   public var input: Input?

   public init() {}
}

open class BaseSceneModel<
   VCModel: VCModelProtocol,
   MainViewModel: ViewModelProtocol,
   Asset: AssetRoot,
   Input,
   Output
>: BaseScene<Input, Output>, SceneModel {
   private var _inputValue: Any?

   public lazy var mainVM = MainViewModel()

   public weak var vcModel: VCModel?

   public var inputValue: Input? { _inputValue as? Input }

   public var events: EventsStore = .init()

   public lazy var retainer = Retainer()

   private var isDismissCalled = false

   override open func start() {
      vcModel?.on(\.dismiss, self) {
         if !$0.isDismissCalled {
            $0.finishWork?.fail()
         }
      }
   }

   override public func setInput(_ value: Any? = nil) {
      _inputValue = value
   }

   override public func dismiss(animated: Bool = true) {
      isDismissCalled = true
      vcModel?.dismiss(animated: animated)
   }

   public func finishSucces(_ value: Output) {
      finishWork?.success(value)
   }

   public func finishSucces() where Output == Void {
      finishWork?.success()
   }

   public func finishCanceled() {
      finishWork?.fail()
   }

   @discardableResult
   public func title(_ value: String) -> Self {
      vcModel?.title = value
      return self
   }

   deinit {
      finishWork = nil
      print("DEINIT SceneModel")
   }

   override public func makeVC() -> UIViewController {
      let model = VCModel(sceneModel: self)
      vcModel = model
      return model
   }

   override public func makeMainView() -> UIView {
      let view = mainVM.uiView
      if let inputValue {
         vcModel?.on(\.updateInputAfterLoad, self) { _ in
            DispatchQueue.main.async {
               self.send(\.input, inputValue)
            }
         }
      }
      return view
   }
}

extension BaseSceneModel: Eventable, Assetable {
   public typealias Events = SceneEvent<Input>
}

// MARK: - Paramitrized Scene

public protocol InOutParams {
   associatedtype Input
   associatedtype Output
}

public protocol SceneModelParams {
   associatedtype VCModel: VCModelProtocol
   associatedtype MainViewModel: ViewModelProtocol
}

public protocol SceneParams {
   associatedtype Asset: AssetRoot
   associatedtype Models: SceneModelParams
   associatedtype InOut: InOutParams
}

open class BaseParamsScene<Params: SceneParams>: BaseSceneModel<
   Params.Models.VCModel,
   Params.Models.MainViewModel,
   Params.Asset,
   Params.InOut.Input,
   Params.InOut.Output
> {}
