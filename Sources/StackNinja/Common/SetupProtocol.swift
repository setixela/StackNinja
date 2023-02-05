//
//  SetupProtocol.swift
//  TeamForce
//
//  Created by Aleksandr Solovyev on 11.09.2022.
//

public protocol SetupProtocol {
   associatedtype Params
   
   func setup(_ data: Params)
}
