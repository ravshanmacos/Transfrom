//
//  AddWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import Foundation

import UIKit
import CoreData
import Combine

class AddWorkoutCoordinator: CoordinatorProtocol{
    
    //MARK: - Properties
    //required
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    // optionals
    weak var parentCoordinator: CreateWorkoutCoordinator?
    var coredataHelper: CoreDataHelper?
    var addWorkoutVC: AddWorkoutController?
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    //MARK: - Actions
    func start() {
        let vc = AddWorkoutController(nibName: nil, bundle: nil)
        vc.coredataHelper = coredataHelper
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        self.addWorkoutVC = vc
    }
    
    func onSaveTap(){
        parentCoordinator?.onSaveTap()
    }
}

//MARK: - Coordinating

extension AddWorkoutCoordinator{
    func workoutDidCreate(_ workout: Workout){
        let child = UpdateWorkoutPartsCoordinator(presenter: navigationController)
        child.parentCoordinator = self
        child.workout = workout
        child.coredataHelper = coredataHelper
        childCoordinators.append(child)
        child.start()
    }
}


