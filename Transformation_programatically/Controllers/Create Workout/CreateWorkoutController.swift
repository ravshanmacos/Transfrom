//
//  CreateWorkoutController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit

protocol CreateWorkoutControllerDelegate: AnyObject{
    func showAlertMessage(message: String)
    func workoutDidCreate(_ workout: WorkoutModel)
}

class CreateWorkoutController: UIViewController, CreateWorkoutControllerDelegate {
    
    private lazy var createWorkoutView: UIView = {
       let view = CreateWorkoutView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Create Workout"
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        
        view.addSubview(createWorkoutView)
    }
    
    private func setupConstraints(){
        createWorkoutView.edgesToSuperview(usingSafeArea: true)
    }
    
    func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func workoutDidCreate(_ workout: WorkoutModel) {
        let editWorkoutPartsVC = EditWorkoutPartsController()
        editWorkoutPartsVC.workout = workout
        navigationController?.pushViewController(editWorkoutPartsVC, animated: true)
    }

}
