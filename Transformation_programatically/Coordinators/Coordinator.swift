//
//  Coordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

protocol Coordinator: AnyObject{
    var childCoordinators: [Coordinator]{get set}
    var navigationController: UINavigationController { get set }
    func start()
}
