//
//  StartWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit

class StartWorkoutController: UIViewController {
    
    //MARK: - Properties
    private lazy var timerView: TimerView = {
        guard let viewModel else{
            return TimerView()
        }
       return TimerView(model: viewModel)
    }()
    //optionals
    weak var coordinator: StartWorkoutCoordinator?
    var selectedWorkout: Workout?
    var viewModel: TimerViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
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
