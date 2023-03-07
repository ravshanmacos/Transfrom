//
//  ChooseWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import TinyConstraints

protocol WorkoutCategoryDelegate: AnyObject{
    func workoutDidSelect(_ workout: String)
}

class WorkoutCategoryController: UIViewController, WorkoutCategoryDelegate {

    //MARK: - Properties
    private let dummyData: [String] = ["New York", "New Jersey","California","Texas","Chicago"]
    
    private lazy var workoutCategoryView = {
       return WorkoutCategoryView(data: dummyData)
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Workout Category"
    }
    
    private func setupDelegates(){
        workoutCategoryView.delegate = self
    }
    
    private func setupViews(){
        view.addSubview(workoutCategoryView)
    }
    private func setupConstraints(){
        workoutCategoryView.edgesToSuperview()
    }
    
    func workoutDidSelect(_ workout: String){
        let startWorkoutVC = StartWorkoutController()
        startWorkoutVC.selectedWorkout = workout
        navigationController?.pushViewController(startWorkoutVC, animated: true)
    }
    
}
