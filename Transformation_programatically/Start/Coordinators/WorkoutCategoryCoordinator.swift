//
//  WorkoutCategoryCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import Combine
import CoreData

class WorkoutCategoryCoordinator: Coordinator{
    //MARK: - Properties
    //tabbar item
    var title: String = "Start"
    var image: UIImage = UIImage
        .init(systemName: Constants.TabbarItemImages.runImageString)!
    var selectedStateImage: UIImage = UIImage
        .init(systemName: "\(Constants.TabbarItemImages.runImageString).fill")!
    
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //core data properties
    private lazy var coredataHelper = CoreDataHelper.shared
    private lazy var fetchedResultsController: NSFetchedResultsController<Workout> = getWorkoutFetchedResultsController()
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    //MARK: - Actions
    func start() {
        //init
        let vc = WorkoutCategoryController(nibName: nil, bundle: nil)
        vc.coordinator = self
        vc.fetchedResultsController = fetchedResultsController
        
        //tabbar item
        vc.title = "Category"
        let tabbarItem = UITabBarItem()
        tabbarItem.title = title
        tabbarItem.image = image
        tabbarItem.selectedImage = selectedStateImage
        vc.tabBarItem = tabbarItem
        
        //navigation
        navigationController.pushViewController(vc, animated: true)
    }
}

//MARK: - Coordinating
extension WorkoutCategoryCoordinator{
    func workoutDidSelect(_ workout: Workout){
        let child = StartWorkoutCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.coredataHelper = coredataHelper
        child.selectedWorkout = workout
        childCoordinators.append(child)
        child.start()
    }
}

//MARK: - Helper Methods
extension WorkoutCategoryCoordinator{
    private func getWorkoutFetchedResultsController()-> NSFetchedResultsController<Workout>{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Workout.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coredataHelper.getManagedContext(),
            sectionNameKeyPath: nil,
            cacheName: nil)
        return fetchedResultsController
    }
    
}
