//
//  Main.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 03.09.2022.
//

import ReactiveWorks

public typealias M = Stack

public struct Stack<M: VMP>: InitProtocol {
   public init() {}
   
   public typealias Ninja = StackNinja<SComboM<M>>
   public typealias R = Right
   public typealias D = Down

   public enum Right<R: VMP> {
      public typealias Ninja = StackNinja<SComboMR<M, R>>
      public typealias R2 = Right2
      public typealias D = Down
      public typealias LD = LeftDown

      public enum Right2<R2: VMP> {
         public typealias Ninja = StackNinja<SComboMRR<M, R, R2>>
         public typealias R3 = Right3
         public typealias D = Down

         public enum Right3<R3: VMP> {
            public typealias Ninja = StackNinja<SComboMRRR<M, R, R2, R3>>
         }

         public enum Down<D: VMP> {
            public typealias Ninja = StackNinja<SComboMRRD<M, R, R2, D>>
         }
      }

      public enum Down<D: VMP> {
         public typealias Ninja = StackNinja<SComboMRD<M, R, D>>
         public typealias R2 = Right2
         public typealias D2 = Down2

         public enum Right2<R2: VMP> {
            public typealias Ninja = StackNinja<SComboMRDR<M, R, D, R2>>
         }

         public enum Down2<D2: VMP> {
            public typealias Ninja = StackNinja<SComboMRDD<M, R, D, D2>>
         }
      }

      public enum LeftDown<LD: VMP> {
         public typealias Ninja = StackNinja<SComboMRLD<M, R, LD>>
      }
   }

   public enum Down<D: VMP> {
      public typealias Ninja = StackNinja<SComboMD<M, D>>
      public typealias R = Right
      public typealias D2 = Down2

      public enum Right<R: VMP> {
         public typealias Ninja = StackNinja<SComboMDR<M, D, R>>
         public typealias R2 = Right2
         public typealias D2 = Down2

         public enum Right2<R2: VMP> {
            public typealias Ninja = StackNinja<SComboMDRR<M, D, R, R2>>
         }

         public enum Down2<D2: VMP> {
            public typealias Ninja = StackNinja<SComboMDRD<M, D, R, D2>>
            public typealias D3 = Down3

            public enum Down3<D3: VMP> {
               public typealias Ninja = StackNinja<SComboMDRDD<M, D, R, D2, D3>>
            }
         }
      }

      public enum Down2<D2: VMP> {
         public typealias Ninja = StackNinja<SComboMDD<M, D, D2>>
         public typealias R = Right
         public typealias D3 = Down3

         public enum Right<R: VMP> {
            public typealias Ninja = StackNinja<SComboMDDR<M, D, D2, R>>
         }

         public enum Down3<D3: VMP> {
            public typealias Ninja = StackNinja<SComboMDDD<M, D, D2, D3>>
            
            public enum Down4<D4: VMP> {
               public typealias Ninja = StackNinja<SComboMDDDD<M, D, D2, D3, D4>>
            }
         }
      }
   }
}
