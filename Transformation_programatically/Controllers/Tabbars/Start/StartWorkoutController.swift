//
//  StartWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit

class StartWorkoutController: UIViewController {
    
    //MARK: - Properties
    
    private var timerViewModel: TimerViewModel{
        return TimerViewModel(workoutParts: workoutParts)
    }
    private lazy var timerView: TimerView = {
       return TimerView(model: timerViewModel)
    }()
    
    private var workoutParts:[WorkoutPart] = []
    //optionals
    weak var coordinator: StartWorkoutCoordinator?
    var selectedWorkout: Workout?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWorkout()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        view.addSubview(timerView)
        
    }
    
    private func setupConstraints(){
        timerView.edgesToSuperview()
    }

}

extension StartWorkoutController{
    private func configureWorkout(){
        guard let selectedWorkout, let workoutPartsSet = selectedWorkout.workoutParts else{return}
        workoutPartsSet.forEach({ el in
            let workoutPart = el as! WorkoutPart
            workoutParts.append(workoutPart)
        })
    }
}
