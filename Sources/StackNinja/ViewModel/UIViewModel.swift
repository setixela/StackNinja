//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

// View Erasing protocol for ViewModelProtocol
public protocol UIViewModel: ModelProtocol {
   var uiView: UIView { get }
   var isAutoreleaseView: Bool { get set }
}
