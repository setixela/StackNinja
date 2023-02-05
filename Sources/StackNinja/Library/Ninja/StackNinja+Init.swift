//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 09.08.2022.
//

import ReactiveWorks

public extension StackNinja {
   convenience init<M>(_ setMain: GenericClosure<M>) where S == SComboM<M> {
      self.init()
      self.setMain(setMain)
   }

   convenience init<M, R>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>
   ) where S == SComboMR<M, R> {
      self.init()
      self.setMain(setMain, setRight: setRight)
   }

   convenience init<M, R, R2>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>
   ) where S == SComboMRR<M, R, R2> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setRight2: setRight2)
   }

   convenience init<M, R, R2, R3>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>,
      setRight3: GenericClosure<R3>
   ) where S == SComboMRRR<M, R, R2, R3> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setRight2: setRight2,
                   setRight3: setRight3)
   }

   convenience init<M, R, D>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setDown: GenericClosure<D>
   ) where S == SComboMRD<M, R, D> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setDown: setDown)
   }

   convenience init<M, R, R2, D>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>,
      setDown: GenericClosure<D>
   ) where S == SComboMRRD<M, R, R2, D> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setRight2: setRight2,
                   setDown: setDown)
   }

   convenience init<M, R, D, R2>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setDown: GenericClosure<D>,
      setRight2: GenericClosure<R2>
   ) where S == SComboMRDR<M, R, D, R2> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setDown: setDown,
                   setRight2: setRight2)
   }

   convenience init<M, R, D, D2>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setDown: GenericClosure<D>,
      setDown2: @escaping GenericClosure<D2>
   ) where S == SComboMRDD<M, R, D, D2> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setDown: setDown,
                   setDown2: setDown2)
   }

   // down

   convenience init<M, D>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>
   ) where S == SComboMD<M, D> {
      self.init()
      self.setMain(setMain, setDown: setDown)
   }

   convenience init<M, D, R>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>
   ) where S == SComboMDR<M, D, R> {
      self.init()
      self.setMain(setMain, setDown: setDown, setRight: setRight)
   }

   convenience init<M, D, D2>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>
   ) where S == SComboMDD<M, D, D2> {
      self.init()
      self.setMain(setMain, setDown: setDown, setDown2: setDown2)
   }
   
   convenience init<M, D, D2, D3>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>,
      setDown3: GenericClosure<D3>
   ) where S == SComboMDDD<M, D, D2, D3> {
      self.init()
      self.setMain(setMain, setDown: setDown, setDown2: setDown2, setDown3: setDown3)
   }
   
   convenience init<M, D, D2, D3, D4>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>,
      setDown3: GenericClosure<D3>,
      setDown4: GenericClosure<D4>
   ) where S == SComboMDDDD<M, D, D2, D3, D4> {
      self.init()
      self.setMain(setMain, setDown: setDown, setDown2: setDown2, setDown3: setDown3, setDown4: setDown4)
   }

   convenience init<M, D, D2, R>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setDown2: GenericClosure<D2>,
      setRight: GenericClosure<R>
   ) where S == SComboMDDR<M, D, D2, R> {
      self.init()
      self.setMain(setMain, setDown: setDown, setDown2: setDown2, setRight: setRight)
   }

   convenience init<M, D, R, D2>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>,
      setDown2: GenericClosure<D2>
   ) where S == SComboMDRD<M, D, R, D2> {
      self.init()
      self.setMain(setMain, setDown: setDown, setRight: setRight, setDown2: setDown2)
   }

   convenience init<M, D, R, D2, D3>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>,
      setDown2: GenericClosure<D2>,
      setDown3: GenericClosure<D3>
   ) where S == SComboMDRDD<M, D, R, D2, D3> {
      self.init()
      self.setMain(setMain, setDown: setDown, setRight: setRight, setDown2: setDown2, setDown3: setDown3)
   }

   convenience init<M, D, R, R2>(
      _ setMain: GenericClosure<M>,
      setDown: GenericClosure<D>,
      setRight: GenericClosure<R>,
      setRight2: GenericClosure<R2>
   ) where S == SComboMDRR<M, D, R, R2> {
      self.init()
      self.setMain(setMain, setDown: setDown, setRight: setRight, setRight2: setRight2)
   }

   convenience init<M, R, LD>(
      _ setMain: GenericClosure<M>,
      setRight: GenericClosure<R>,
      setLeftDown: GenericClosure<LD>
   ) where S == SComboMRLD<M, R, LD> {
      self.init()
      self.setMain(setMain,
                   setRight: setRight,
                   setLeftDown: setLeftDown)
   }
}
