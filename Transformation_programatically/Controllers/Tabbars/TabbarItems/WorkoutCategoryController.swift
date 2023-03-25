//
//  ChooseWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import TinyConstraints
import Combine

protocol WorkoutCategoryDelegate: AnyObject{
    func workoutDidSelect(_ title: String)
}

class WorkoutCategoryController: UIViewController, WorkoutCategoryDelegate {

    //MARK: - Properties
    private let coredataHelper = CoreDataHelper.shared
    private lazy var workouts: [Workout] = {
        return coredataHelper.fetchAll()
    }()
    private lazy var workoutCategoryView = configureWorkoutCategoryView()
    
    weak var coordinator: WorkoutCategoryCoordinator?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
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
        var view = WorkoutCategoryView(data: workouts.map{$0.name!})
        if workouts.isEmpty{
            view = WorkoutCategoryView(data: [])
        }
        view.delegate = self
       return view
    }
}

//MARK: - Helper Functions
extension WorkoutCategoryController{
    func workoutDidSelect(_ title: String) {
        coordinator?.workoutDidSelect(title)
    }
}
