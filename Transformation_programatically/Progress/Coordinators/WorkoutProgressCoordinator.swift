//
//  WorkoutProgressCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine

class WorkoutProgressCoordinator: CoordinatorProtocol{
    //MARK: - Properties
    
    //tabbar item
    private var title: String = "Progress"
    private var image: UIImage = UIImage
        .init(systemName: Constants.TabbarItemImages.chartImageString)!
    private var selectedStateImage: UIImage = UIImage
        .init(systemName: "\(Constants.TabbarItemImages.chartImageString).fill")!
    
    //required
    private let viewModel = ProgressTableviewViewModel()
    private var cancellables: [AnyCancellable] = []
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    //MARK: - LifeCycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
        setubPublishers()
    }
    
   //MARK: - Actions
    func start() {
        let vc = ProgressTableViewController(nibName: nil, bundle: nil)
        vc.title = "Progress"
        vc.viewModel = viewModel
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedStateImage)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func setubPublishers(){
        viewModel.$workout.dropFirst(1).sink {[weak self] value in
            guard let self, let value else {return}
            self.workoutTypeDidSelect(value)
        }.store(in: &cancellables)
    }
}

//MARK: - Coordinating
extension WorkoutProgressCoordinator{
    private func workoutTypeDidSelect(_ workout: Workout){
        let child = AnalysisCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.workout = workout
        childCoordinators.append(child)
        child.start()
    }
}
