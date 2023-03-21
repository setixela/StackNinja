//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 21.03.2023.
//

public func impossible<T>() -> T { { fatalError() }() }
