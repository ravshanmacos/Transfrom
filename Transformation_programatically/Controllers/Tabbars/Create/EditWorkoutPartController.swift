//
//  EditWorkoutPartController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/04.
//

import UIKit
import CoreData

protocol EditWorkoutPartControllerDelegate: AnyObject{
    func editWorkoutPartControllerDidCancel()
    func editWorkoutPartControllerSaveTapped(data: [String: Any])
}

class EditWorkoutPartController: UIViewController {
    
    private lazy var updateWorkoutPartView: UIView = {
        if let workoutPart{
            let view = UpdateWorkoutPartView(model: workoutPart)
            view.delegate = self
            return view
        }
        return AddWorkoutView()
    }()
    var workoutPart: WorkoutPart?
    weak var coordinator: UpdateCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupMainView(){
        view.backgroundColor = .white
        view.addSubview(updateWorkoutPartView)
        
    }
    private func setupConstraints(){
        updateWorkoutPartView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func setupDelegates(){}
    
    

}

extension EditWorkoutPartController: EditWorkoutPartControllerDelegate{
    func editWorkoutPartControllerDidCancel() {}
    func editWorkoutPartControllerSaveTapped(data: [String: Any]) {
        guard let workoutPart = workoutPart else{return}
        coordinator?.workoutPartDidUpdate(workoutPart, data: data)
    }
}
