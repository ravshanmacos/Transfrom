//
//  CreateWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import CoreData

protocol CreateWorkoutControllerDelegate: AnyObject{
    func workoutDidSelect(_ workout: Workout)
    func workoutDidDelete(_ workout: Workout)
    func addTapped()
}

class CreateWorkoutController: UIViewController {
    //MARK: - Properties
    
    //UI properties
    private lazy var createWorkoutView: UIView = setupCreateWorkoutView()
    
    //optionals
    var coredataHelper: CoreDataHelper?
    weak var coordinator: CreateWorkoutCoordinator?
    var fetchedResultsController: NSFetchedResultsController<Workout>?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorkouts()
        setupViews()
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Actions
    
    private func loadWorkouts(){
        guard let fetchedResultsController else{
            print("fetched results controller does not exist")
            return
        }
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("failed performing fetch workouts\(error.localizedDescription)")
        }
    }
    
}
//MARK: - UI Helper Methods
extension CreateWorkoutController{
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(createWorkoutView)
        createWorkoutView.edgesToSuperview(usingSafeArea: true)
    }
    private func setupDelegates(){}
    
    private func setupCreateWorkoutView()-> CreateWorkoutView{
        if let fetchedResultsController{
            let view = CreateWorkoutView(fetchedResultsController: fetchedResultsController)
            view.delegate = self
            return view
        }
        print("fetched results controller does not exist")
        return CreateWorkoutView()
    }
}


//MARK: - CreateWorkoutViewControllerDelegate
extension CreateWorkoutController: CreateWorkoutControllerDelegate{
    func workoutDidSelect(_ workout: Workout) {
        coordinator?.updateWorkout(for: workout)
    }
    
    func workoutDidDelete(_ workout: Workout) {
        coredataHelper!.delete(workout)
    }
    
    func addTapped() {
        coordinator?.addWorkout()
    }
}


