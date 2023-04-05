//
//  EditWorkoutPartCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/02.
//

import UIKit
import Combine

class EditWorkoutPartCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    private let viewModel: EditWorkoutPartViewModel
    private var cancellables: [AnyCancellable] = []
    weak var parentCoordinator: UpdateCoordinatorProtocol?
    
    init(presenter: UINavigationController, workoutPart: WorkoutPart) {
        self.navigationController = presenter
        self.viewModel = EditWorkoutPartViewModel(workoutPart: workoutPart)
        self.setupPublishers()
    }
    
    func setupPublishers(){
        viewModel.$isDataUpdated.dropFirst(1).sink {[weak self] data in
            guard let self else { return }
            parentCoordinator?.workoutPartDidUpdate(viewModel.workoutPart, data: data)
        }.store(in: &cancellables)
    }
    
    func start() {
        let vc = EditWorkoutPartController(nibName: nil, bundle: nil)
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true)
    }
    
    
}
