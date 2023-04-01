//
//  ChooseWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import TinyConstraints
import Combine
import CoreData

protocol WorkoutCategoryDelegate: AnyObject{
    func workoutDidSelect(_ workout: Workout)
}

class WorkoutCategoryController: UIViewController, WorkoutCategoryDelegate {

    //MARK: - Properties
    private lazy var workoutCategoryView = configureWorkoutCategoryView()
    private let coredataHelper = CoreDataHelper.shared
    
    //optionals
    var fetchedResultsController: NSFetchedResultsController<Workout>?
    weak var coordinator: WorkoutCategoryCoordinator?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Setups
    private func setupViews(){
        tabBarController?.navigationController?.isNavigationBarHidden = true
        view.addSubview(workoutCategoryView)
        workoutCategoryView.edgesToSuperview()
    }
    private func setupDelegates(){}
}

//MARK: - UI Helper Functions
extension WorkoutCategoryController{
    private func configureWorkoutCategoryView()-> WorkoutCategoryView{
        let view = WorkoutCategoryView(fetchedResultsController)
        view.delegate = self
       return view
    }
}

//MARK: - Helper Functions
extension WorkoutCategoryController{
    func workoutDidSelect(_ workout: Workout) {
        coordinator?.workoutDidSelect(workout)
    }
}
