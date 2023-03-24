//
//  CreateWorkoutCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/12.
//

import UIKit
import CoreData
import Combine

class CreateWorkoutCoordinator: Coordinator{
    
    //MARK: - Properties
    //tabbar item properties
    private var title: String = "Create"
    private var image: UIImage = UIImage.init(
        systemName: Constants.TabbarItemImages.plusImageString)!
    private var selectedStateImage: UIImage = UIImage.init(
        systemName: "\(Constants.TabbarItemImages.plusImageString).fill")!
    
    //core data properties
    private lazy var coredataHelper = CoreDataHelper.shared
    private lazy var fetchedResultsController: NSFetchedResultsController<Workout> = getWorkoutFetchedResultsController()
    
    //required
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    //optionals
    var createWorkoutVC:  CreateWorkoutController?
    
    //MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.navigationController = presenter
    }
    
    //MARK: - Actions
    func start() {
        //initializing view controller
        let vc = CreateWorkoutController(nibName: nil, bundle: nil)
        vc.title = "Workouts"
        vc.coordinator = self
        vc.coredataHelper = coredataHelper
        vc.fetchedResultsController = fetchedResultsController
        
        //initializng tabbar item
        let tabbarItem = UITabBarItem()
        tabbarItem.title = title
        tabbarItem.image = image
        tabbarItem.selectedImage = selectedStateImage
        vc.tabBarItem = tabbarItem
        
        //navigating
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
        child.coredataHelper = coredataHelper
        childCoordinators.append(child)
        child.start()
    }
    
    func updateWorkout(for workout: Workout){
        let child = UpdateWorkoutCoordinator(presenter: navigationController)
        child.parentCoordinator = self
        child.coredataHelper = coredataHelper
        child.workout = workout
        childCoordinators.append(child)
        child.start()
    }
}

//MARK: - Helper Methods
extension CreateWorkoutCoordinator{
    
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
