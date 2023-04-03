//
//  Coordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/05.
//

import UIKit

protocol CoordinatorProtocol: AnyObject{
    var childCoordinators: [CoordinatorProtocol]{get set}
    var navigationController: UINavigationController { get set }
    func start()
}
