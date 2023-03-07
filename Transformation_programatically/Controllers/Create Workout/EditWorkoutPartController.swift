//
//  EditWorkoutPartController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/04.
//

import UIKit

protocol EditWorkoutPartControllerDelegate: AnyObject{
    func editWorkoutPartControllerDidCancel()
}

class EditWorkoutPartController: UIViewController {
    
    private lazy var createWorkoutPartView: UIView = {
        if let workoutPart{
            let view = CreateWorkoutPartView(model: workoutPart)
            view.delegate = self
            return view
        }
        return CreateWorkoutView()
    }()
    
    var workoutPart: WorkoutPart?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupViews()
        setupConstraints()
    }
    
    private func setupMainView(){
        view.backgroundColor = .white
        view.addSubview(createWorkoutPartView)
        
    }
    
    private func setupViews(){
        
    }
    
    private func setupConstraints(){
        createWorkoutPartView.edgesToSuperview(usingSafeArea: true)
    }

}

extension EditWorkoutPartController: EditWorkoutPartControllerDelegate{
    func editWorkoutPartControllerDidCancel() {
        dismiss(animated: true)
    }
}
