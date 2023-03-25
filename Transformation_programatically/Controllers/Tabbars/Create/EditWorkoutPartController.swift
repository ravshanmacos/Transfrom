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
    
    //MARK: - Properties
    private lazy var updateWorkoutPartView: EditWorkoutPartView = configureEditWorkoutPartView()
   
    //optionals
    var workoutPart: WorkoutPart?
    weak var coordinator: UpdateCoordinator?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupConstraints()
        setupDelegates()
    }
    
    //MARK: - Setups
    private func setupMainView(){
        view.backgroundColor = .white
        view.addSubview(updateWorkoutPartView)
        
    }
    private func setupConstraints(){
        updateWorkoutPartView.edgesToSuperview(usingSafeArea: true)
    }
    private func setupDelegates(){}
}

//MARK: - UI Helper Functions
extension EditWorkoutPartController{
    private func configureEditWorkoutPartView()-> EditWorkoutPartView{
        if let workoutPart{
            let view = EditWorkoutPartView(model: workoutPart)
            view.delegate = self
            return view
        }
        return EditWorkoutPartView()
    }
}

//MARK: - EditWorkoutPartControllerDelegate
extension EditWorkoutPartController: EditWorkoutPartControllerDelegate{
    func editWorkoutPartControllerDidCancel() {}
    func editWorkoutPartControllerSaveTapped(data: [String: Any]) {
        guard let workoutPart = workoutPart else{return}
        coordinator?.workoutPartDidUpdate(workoutPart, data: data)
    }
}
