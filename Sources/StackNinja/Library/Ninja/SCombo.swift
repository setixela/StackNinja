//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 09.08.2022.
//

import ReactiveWorks

public protocol SCP: InitProtocol {}

// right

public struct SComboM<M: VMP>: SCP {
   public init(main: M) {
      self.main = main
   }

   public init() {}

   public var main: M = .init()
}

public struct SComboMR<M: VMP, R: VMP>: SCP {
   public init(main: M, right: R) {
      self.main = main
      self.right = right
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()

   // M>R
}

public struct SComboMRR<M: VMP, R: VMP, R2: VMP>: SCP {
   public init(main: M, right: R, right2: R2) {
      self.main = main
      self.right = right
      self.right2 = right2
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var right2: R2 = .init()

   // M>R>R
}

public struct SComboMRRR<M: VMP, R: VMP, R2: VMP, R3: VMP>: SCP {
   public init(main: M, right: R, right2: R2, right3: R3) {
      self.main = main
      self.right = right
      self.right2 = right2
      self.right3 = right3
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var right2: R2 = .init()
   public var right3: R3 = .init()

   // M>R>R>R
}

public struct SComboMRD<M: VMP, R: VMP, D: VMP>: SCP {
   public init(main: M, right: R, down: D) {
      self.main = main
      self.right = right
      self.down = down
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var down: D = .init()
}

public struct SComboMRRD<M: VMP, R: VMP, R2: VMP, D: VMP>: SCP {
   public init(main: M, right: R, right2: R2, down: D) {
      self.main = main
      self.right = right
      self.right2 = right2
      self.down = down
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var right2: R2 = .init()
   public var down: D = .init()
}

public struct SComboMRDR<M: VMP, R: VMP, D: VMP, R2: VMP>: SCP {
   public init(main: M, right: R, down: D, right2: R2) {
      self.main = main
      self.right = right
      self.down = down
      self.right2 = right2
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var down: D = .init()
   public var right2: R2 = .init()
}

public struct SComboMRDD<M: VMP, R: VMP, D: VMP, D2: VMP>: SCP {
   public init(main: M, right: R, down: D, down2: D2) {
      self.main = main
      self.right = right
      self.down = down
      self.down2 = down2
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var down: D = .init()
   public var down2: D2 = .init()
}

// down

public struct SComboMD<M: VMP, D: VMP>: SCP {
   public init(main: M, down: D) {
      self.main = main
      self.down = down
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
}

public struct SComboMDR<M: VMP, D: VMP, R: VMP>: SCP {
   public init(main: M, down: D, right: R) {
      self.main = main
      self.down = down
      self.right = right
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var right: R = .init()
}

public struct SComboMDD<M: VMP, D: VMP, D2: VMP>: SCP {
   public init(main: M, down: D, down2: D2) {
      self.main = main
      self.down = down
      self.down2 = down2
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var down2: D2 = .init()
}

public struct SComboMDDR<M: VMP, D: VMP, D2: VMP, R: VMP>: SCP {
   public init(main: M, down: D, down2: D2, right: R) {
      self.main = main
      self.down = down
      self.down2 = down2
      self.right = right
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var down2: D2 = .init()
   public var right: R = .init()
}

public struct SComboMDRD<M: VMP, D: VMP, R: VMP, D2: VMP>: SCP {
   public init(main: M, down: D, right: R, down2: D2) {
      self.main = main
      self.down = down
      self.right = right
      self.down2 = down2
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var right: R = .init()
   public var down2: D2 = .init()
}

public struct SComboMDRDD<M: VMP, D: VMP, R: VMP, D2: VMP, D3: VMP>: SCP {
   public init(main: M, down: D, right: R, down2: D2, down3: D3) {
      self.main = main
      self.down = down
      self.right = right
      self.down2 = down2
      self.down3 = down3
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var right: R = .init()
   public var down2: D2 = .init()
   public var down3: D3 = .init()
}

public struct SComboMDRR<M: VMP, D: VMP, R: VMP, R2: VMP>: SCP {
   public init(main: M, down: D, right: R, right2: R2) {
      self.main = main
      self.down = down
      self.right = right
      self.right2 = right2
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var right: R = .init()
   public var right2: R2 = .init()
}

public struct SComboMDDD<M: VMP, D: VMP, D2: VMP, D3: VMP>: SCP {
   public init(main: M, down: D, down2: D2, down3: D3) {
      self.main = main
      self.down = down
      self.down2 = down2
      self.down3 = down3
   }

   public init() {}

   public var main: M = .init()
   public var down: D = .init()
   public var down2: D2 = .init()
   public var down3: D3 = .init()
}

public struct SComboMDDDD<M: VMP, D: VMP, D2: VMP, D3: VMP, D4: VMP>: SCP {
   public init(main: M, down: D, down2: D2, down3: D3, down4: D4) {
      self.main = main
      self.down = down
      self.down2 = down2
      self.down3 = down3
      self.down4 = down4
   }
   
   public init() {}
   
   public var main: M = .init()
   public var down: D = .init()
   public var down2: D2 = .init()
   public var down3: D3 = .init()
   public var down4: D4 = .init()
}

public struct SComboMRLD<M: VMP, R: VMP, LD: VMP>: SCP {
   public init(main: M, right: R, leftDown: LD) {
      self.main = main
      self.right = right
      self.leftDown = leftDown
   }

   public init() {}

   public var main: M = .init()
   public var right: R = .init()
   public var leftDown: LD = .init()
}
