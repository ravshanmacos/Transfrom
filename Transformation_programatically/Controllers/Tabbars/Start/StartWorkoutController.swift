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
        return TimerViewModel(workouts: [])
    }
    private lazy var timerView: TimerView = {
       return TimerView(model: timerViewModel)
    }()
    weak var coordinator: StartWorkoutCoordinator?
    var selectedWorkout: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedWorkout)
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
