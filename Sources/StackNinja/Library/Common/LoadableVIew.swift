//
//  File.swift
//  
//
//  Created by Aleksandr Solovyev on 03.02.2023.
//

import UIKit

public protocol LoadableView: UIView {
   var activityModel: UIViewModel? { get set }
}
