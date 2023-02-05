//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 07.08.2022.
//

import ReactiveWorks
import UIKit

// MARK: - Right combos

open class StackNinja<S: SCP>: BaseViewModel<StackViewExtended> {
   public let models: S = .init()

   private var isConfigured = false

   @discardableResult
   public func set<M>(_ keypath: KeyPath<S, M>, closure: GenericClosure<M>) -> Self {
      let model = models[keyPath: keypath]
      closure(model)
      return self
   }
}

extension StackNinja: Stateable {
   public typealias State = StackState
}

public extension StackNinja {
   @discardableResult func setMain<M>(_ setMain: GenericClosure<M>) -> Self where S == SComboM<M> {
      setMain(models.main)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // right

   @discardableResult func setMain<M, R>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>
   ) -> Self where S == SComboMR<M, R> {
      setMain(models.main)
      setRight(models.right)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, R>(
      _ setAll: VariadicClosure2<M, R>) -> Self where S == SComboMR<M, R>
   {
      setAll(models.main, models.right)

      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, R, R2>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>
   ) -> Self where S == SComboMRR<M, R, R2> {
      setMain(models.main)
      setRight(models.right)
      setRight2(models.right2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, R, R2>(
      _ setAll: VariadicClosure3<M, R, R2>) -> Self where S == SComboMRR<M, R, R2>
   {
      setAll(models.main, models.right, models.right2)

      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, R, R2, R3>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>,
      setRight3: GenericClosure<R3>
   ) -> Self where S == SComboMRRR<M, R, R2, R3> {
      setMain(models.main)
      setRight(models.right)
      setRight2(models.right2)
      setRight3(models.right3)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, R, R2, R3>(_ setAll: VariadicClosure4<M, R, R2, R3>) -> Self where S == SComboMRRR<M, R, R2, R3>
   {
      setAll(models.main, models.right, models.right2, models.right3)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, R, D>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setDown: GenericClosure<D>
   ) -> Self where S == SComboMRD<M, R, D> {
      setMain(models.main)
      setRight(models.right)
      setDown(models.down)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, R, D>(_ setAll: VariadicClosure3<M, R, D>) -> Self where S == SComboMRD<M, R, D>
   {
      setAll(models.main, models.right, models.down)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, R, R2, D>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>,
      setDown: GenericClosure<D>
   ) -> Self where S == SComboMRRD<M, R, R2, D> {
      setMain(models.main)
      setRight(models.right)
      setRight2(models.right2)
      setDown(models.down)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, R, D, R2>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setDown: GenericClosure<D>,
      setRight2: GenericClosure<R2>
   ) -> Self where S == SComboMRDR<M, R, D, R2> {
      setMain(models.main)
      setRight(models.right)
      setDown(models.down)
      setRight2(models.right2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setAll<M, R, D, R2>(_ setAll: VariadicClosure4<M, R, D, R2>) -> Self where S == SComboMRDR<M, R, D, R2>
   {
      setAll(models.main, models.right, models.down, models.right2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, R, D, D2>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>? = nil
   ) -> Self where S == SComboMRDD<M, R, D, D2> {
      setMain(models.main)
      setRight(models.right)
      setDown(models.down)
      setDown2?(models.down2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // down

   @discardableResult func setMain<M, D>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>
   ) -> Self where S == SComboMD<M, D> {
      setMain(models.main)
      setDown(models.down)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setAll<M, D>(_ setAll: VariadicClosure2<M, D>) -> Self where S == SComboMD<M, D>
   {
      setAll(models.main, models.down)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, R>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>
   ) -> Self where S == SComboMDR<M, D, R> {
      setMain(models.main)
      setDown(models.down)
      setRight(models.right)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, D, R>(
      _ setAll: VariadicClosure3<M, D, R>) -> Self where S == SComboMDR<M, D, R>
   {
      setAll(models.main, models.down, models.right)

      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, D2>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>
   ) -> Self where S == SComboMDD<M, D, D2> {
      setMain(models.main)
      setDown(models.down)
      setDown2(models.down2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setAll<M, D, D2>(
      _ setAll: VariadicClosure3<M, D, D2>) -> Self where S == SComboMDD<M, D, D2>
   {
      setAll(models.main, models.down, models.down2)

      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, D2, R>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>,
      setRight: GenericClosure<R>
   ) -> Self where S == SComboMDDR<M, D, D2, R> {
      setMain(models.main)
      setDown(models.down)
      setDown2(models.down2)
      setRight(models.right)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, R, D2>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>,
      setDown2: GenericClosure<D2>
   ) -> Self where S == SComboMDRD<M, D, R, D2> {
      setMain(models.main)
      setDown(models.down)
      setRight(models.right)
      setDown2(models.down2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, R, D2, D3>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>,
      setDown2: GenericClosure<D2>,
      setDown3: GenericClosure<D3>
   ) -> Self where S == SComboMDRDD<M, D, R, D2, D3> {
      setMain(models.main)
      setDown(models.down)
      setRight(models.right)
      setDown2(models.down2)
      setDown3(models.down3)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, D, R, D2, D3>(
      _ setAll: VariadicClosure5<M, D, R, D2, D3>) -> Self where S == SComboMDRDD<M, D, R, D2, D3>
   {
      setAll(models.main, models.down, models.right, models.down2, models.down3)

      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, R, R2>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>
   ) -> Self where S == SComboMDRR<M, D, R, R2> {
      setMain(models.main)
      setDown(models.down)
      setRight(models.right)
      setRight2(models.right2)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   // MARK: - New setAll

   @discardableResult func setAll<M, D, D2, D3>(
      _ setAll: VariadicClosure4<M, D, D2, D3>) -> Self where S == SComboMDDD<M, D, D2, D3>
   {
      setAll(models.main, models.down, models.down2, models.down3)

      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

   @discardableResult func setMain<M, D, D2, D3>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>,
      setDown3: GenericClosure<D3>
   ) -> Self where S == SComboMDDD<M, D, D2, D3> {
      setMain(models.main)
      setDown(models.down)
      setDown2(models.down2)
      setDown3(models.down3)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }
   
   // MARK: - New setAll
   
   @discardableResult func setAll<M, D, D2, D3, D4>(
      _ setAll: VariadicClosure5<M, D, D2, D3, D4>) -> Self where S == SComboMDDDD<M, D, D2, D3, D4>
   {
      setAll(models.main, models.down, models.down2, models.down3, models.down4)
      
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }
   
   @discardableResult func setMain<M, D, D2, D3, D4>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>,
      setDown3: GenericClosure<D3>,
      setDown4: GenericClosure<D4>
   ) -> Self where S == SComboMDDDD<M, D, D2, D3, D4> {
      setMain(models.main)
      setDown(models.down)
      setDown2(models.down2)
      setDown3(models.down3)
      setDown4(models.down4)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }
   // MARK: - New setAll

   @discardableResult func setAll<M, R, LD>(_ setAll: VariadicClosure3<M, R, LD>) -> Self where S == SComboMRLD<M, R, LD>
   {
      setAll(models.main, models.right, models.leftDown)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }
   
   @discardableResult func setMain<M, R, LD>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setLeftDown: GenericClosure<LD>
   ) -> Self where S == SComboMRLD<M, R, LD> {
      setMain(models.main)
      setRight(models.right)
      setLeftDown(models.leftDown)
      if !isConfigured {
         configure()
         isConfigured = true
      }
      return self
   }

}
