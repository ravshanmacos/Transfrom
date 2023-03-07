//
//  StartWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit

class StartWorkoutController: UIViewController {
    
    //MARK: - Properties
    private let workouts = [
     Workout(name: "Planks", duration: 60),
     Workout(name: "Push ups", duration: 60),
     Workout(name: "jumping Jacks", duration: 60),
     Workout(name: "Squats", duration: 60),
     Workout(name: "Run", duration: 60)
    ]
    private var timerViewModel: TimerViewModel{
        return TimerViewModel(workouts: workouts)
    }
    private lazy var timerView: TimerView = {
       return TimerView(model: timerViewModel)
    }()
    var selectedWorkout: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        navigationItem.title = "Start Workout"
        view.addSubview(timerView)
        
    }
    
    private func setupConstraints(){
        timerView.edgesToSuperview()
    }

}
