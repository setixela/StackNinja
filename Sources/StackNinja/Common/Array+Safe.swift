//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 01.08.2023.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
