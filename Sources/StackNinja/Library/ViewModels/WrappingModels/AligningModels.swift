//
//  AligningModels.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 12.08.2022.
//

import ReactiveWorks
import UIKit

public extension ViewModelProtocol {
   func centeredX() -> CenteredX<Self> {
      CenteredX(self)
   }

   func centeredY() -> CenteredY<Self> {
      CenteredY(self)
   }

   func lefted() -> Lefted<Self> {
      Lefted(self)
   }

   func righted() -> Righted<Self> {
      Righted(self)
   }

   func wrappedX() -> WrappedX<Self> {
      WrappedX(self)
   }

   func wrappedY() -> WrappedY<Self> {
      WrappedY(self)
   }

   func toped() -> Toped<Self> {
      Toped(self)
   }

   func bottomed() -> Bottomed<Self> {
      Bottomed(self)
   }
}

// Центрирует в .fill стеках
public final class CenteredX<VM: VMP>: BaseViewModel<StackViewExtended>, Stateable, VMWrapper {
   public typealias State = StackState

   public lazy var subModel = VM()

   override public func start() {
      set(.axis(.vertical))
      set(.alignment(.center))
      set(.distribution(.equalSpacing))
      set(.arrangedModels([
         subModel,
      ]))
   }
}

// Центрирует в .fill стеках
public final class CenteredY<VM: VMP>: BaseViewModel<StackViewExtended>, Stateable, VMWrapper {
   public typealias State = StackState

   public lazy var subModel = VM()

   override public func start() {
      set(.axis(.horizontal))
      set(.alignment(.center))
      set(.distribution(.equalSpacing))
      set(.arrangedModels([
         subModel,
      ]))
   }
}

// обжимает модель с двух сторон, для увода влево в .fill стеках
public final class Lefted<VM: VMP>: BaseViewModel<StackViewExtended>, Stateable, VMWrapper {
   public typealias State = StackState

   public lazy var subModel = VM()

   override public func start() {
      set(.axis(.horizontal))
      set(.distribution(.fill))
      set(.arrangedModels([
         subModel,
         Spacer(),
      ]))
   }
}

// обжимает модель с двух сторон, для увода вправо в .fill стеках
public final class Righted<VM: VMP>: BaseViewModel<StackViewExtended>, Stateable, VMWrapper {
   public typealias State = StackState

   public lazy var subModel = VM()

   override public func start() {
      set(.axis(.horizontal))
      set(.distribution(.fill))
      set(.arrangedModels([
         Spacer(),
         subModel,
      ]))
   }
}

// обжимает модель с двух сторон, для увода вверх в .fill стеках\
public final class Toped<VM: VMP>: BaseViewModel<StackViewExtended>, Stateable, VMWrapper {
   public typealias State = StackState

   public lazy var subModel = VM()

   override public func start() {
      set(.axis(.vertical))
      set(.distribution(.fill))
      set(.arrangedModels([
         subModel,
         Spacer(),
      ]))
   }
}

// обжимает модель с двух сторон, для увода вниз в .fill стеках
public final class Bottomed<VM: VMP>: BaseViewModel<StackViewExtended>, Stateable, VMWrapper {
   public typealias State = StackState

   public lazy var subModel = VM()

   override public func start() {
      set(.axis(.vertical))
      set(.distribution(.fill))
      set(.arrangedModels([
         Spacer(),
         subModel,
      ]))
   }
}

