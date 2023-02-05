//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import Foundation

public extension Optional where Wrapped == String {
   var string: String { self ?? "" }
}

public extension Optional where Wrapped == Bool {
   var bool: Bool { self ?? false }
}

public extension Optional where Wrapped == Int {
   var int: Int { self ?? 0 }
}
