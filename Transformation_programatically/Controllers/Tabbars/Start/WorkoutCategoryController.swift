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
    private lazy var workoutCategoryView = {
        var view: WorkoutCategoryView
        if workouts.isEmpty{
            view = WorkoutCategoryView(data: [])
        }else{
            view = WorkoutCategoryView(data: workouts.map{$0.name!})
        }
        view.delegate = self
       return view
    }()
    
    weak var coordinator: WorkoutCategoryCoordinator?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationController?.isNavigationBarHidden = true
        setupDelegates()
        setupViews()
        setupConstraints()
    }
    
    private func setupDelegates(){
     
    }
    
    private func setupViews(){
        view.addSubview(workoutCategoryView)
    }
    private func setupConstraints(){
        workoutCategoryView.edgesToSuperview()
    }
    
    func workoutDidSelect(_ title: String) {
        coordinator?.workoutDidSelect(title)
    }
    
}
