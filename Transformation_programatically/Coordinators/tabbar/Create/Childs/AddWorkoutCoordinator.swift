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

class AddWorkoutCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var coredataHelper: CoreDataHelper?
    weak var parentCoordinator: CreateWorkoutCoordinator?
    var addWorkoutVC: AddWorkoutController?
    
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    func start() {
        let vc = AddWorkoutController(nibName: nil, bundle: nil)
        vc.coredataHelper = coredataHelper
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        self.addWorkoutVC = vc
    }
    
    func workoutDidCreate(_ workout: Workout){
        let child = UpdateWorkoutPartsCoordinator(presenter: navigationController)
        child.parentCoordinator = self
        child.workout = workout
        child.coredataHelper = coredataHelper
        childCoordinators.append(child)
        child.start()
    }
    
    func onSaveTap(){
        parentCoordinator?.onSaveTap()
    }
}


