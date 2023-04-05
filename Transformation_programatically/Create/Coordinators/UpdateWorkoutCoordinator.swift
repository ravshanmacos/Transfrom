//
//  UpdateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import Combine

class UpdateWorkoutCoordinator: CoordinatorProtocol{
    //MARK: - Properties
    //required
    private let viewModel: UpdateWorkoutViewModel
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    private var cancellables: [AnyCancellable] = []
    private var updateWorkoutVC: UpdateWorkoutController?
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController, _ workout: Workout, _ coredataHelper: CoreDataHelper) {
        self.navigationController = presenter
        viewModel = UpdateWorkoutViewModel(workout, coredataHelper: coredataHelper)
        setupPublishers()
    }
    
    func setupPublishers(){
        viewModel.$workoutPart.dropFirst(1)
            .sink {[weak self] value in
            guard let self else { return }
            if let value{
                self.editWorkoutPart(value)
            }
        }.store(in: &cancellables)
        
        viewModel.$isAddWorkoutTapped.dropFirst(1)
            .sink {[weak self] value in
                guard let self else {return}
                if value {
                    self.navigationController.popToRootViewController(animated: true)
                }
            }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    func start() {
        let vc = UpdateWorkoutController(nibName: nil, bundle: nil)
        vc.title = "Update"
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        self.updateWorkoutVC = vc
    }
    
    func editWorkoutPart(_ workoutPart: WorkoutPart){
        let child = EditWorkoutPartCoordinator(presenter: navigationController, workoutPart: workoutPart)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    deinit {
        print("deinit UpdateWorkoutCoordinator")
    }
}


//MARK: - UpdateCoordinatorProtocol
extension UpdateWorkoutCoordinator: UpdateCoordinatorProtocol{
    func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any]) {
        guard let updateWorkoutVC else{return}
        updateWorkoutVC.updateWorkoutParts(with: workoutPart, data: data)
        navigationController.dismiss(animated: true)
    }
}



