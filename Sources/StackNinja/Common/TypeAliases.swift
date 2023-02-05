//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit
import ReactiveWorks

public typealias VMP = ViewModelProtocol
public typealias VMPS = VMP & Stateable
public typealias VMPS2 = VMP & Stateable2
public typealias BVM = BaseViewModel
public typealias BVMA<U:UIView> = BaseViewModel<U> & Assetable
public typealias SMP = SceneModelProtocol
public typealias BSM = BaseSceneModel
