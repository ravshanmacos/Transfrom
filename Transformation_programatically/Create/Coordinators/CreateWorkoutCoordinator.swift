//
//  CreateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine

class CreateWorkoutCoordinator: CoordinatorProtocol{
    
    //MARK: - Properties
    //tabbar item properties
    private var title: String = "Create"
    private var image: UIImage = UIImage.init(
        systemName: Constants.TabbarItemImages.plusImageString)!
    private var selectedStateImage: UIImage = UIImage.init(
        systemName: "\(Constants.TabbarItemImages.plusImageString).fill")!
    
    //required
    private let viewModel: CreateWorkoutViewModel
    private var cancellables: [AnyCancellable] = []
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    //optionals
    var createWorkoutVC:  CreateWorkoutController?
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
        self.viewModel = CreateWorkoutViewModel()
        setupPublishers()
    }
    
    private func setupPublishers(){
        viewModel.$workout.dropFirst(1).sink {[weak self] value in
            guard let self, let value else {return}
            self.updateWorkout(for: value)
        }.store(in: &cancellables)
        
        viewModel.$isAddTapped.dropFirst(1).sink {[weak self] value in
            guard let self else {return}
            if value {
                self.addWorkout()
            }
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    func start() {
        //initializing view controller
        let vc = CreateWorkoutController(nibName: nil, bundle: nil)
        vc.title = "Workouts"
        vc.viewModel = viewModel
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedStateImage)
        navigationController.pushViewController(vc, animated: true)
        self.createWorkoutVC = vc
    }
    
    func onSaveTap(){
        guard let createWorkoutVC else{return}
        navigationController.popToViewController(createWorkoutVC, animated: true)
    }
}

//MARK: - Coordinating
extension CreateWorkoutCoordinator{
    func addWorkout(){
        let child = AddWorkoutCoordinator(presenter: navigationController)
        child.parentCoordinator = self
        child.coredataHelper = viewModel.coredataHelper
        childCoordinators.append(child)
        child.start()
    }
    
    func updateWorkout(for workout: Workout){
        let child = UpdateWorkoutCoordinator(presenter: navigationController, workout, viewModel.coredataHelper)
        childCoordinators.append(child)
        child.start()
    }
}


