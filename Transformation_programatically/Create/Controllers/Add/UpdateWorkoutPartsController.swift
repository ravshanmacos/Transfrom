//
//  EditWorkoutPartsController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import CoreData

class UpdateWorkoutPartsController: UIViewController {
    
    //MARK: - Properties
    private lazy var updateWokroutPartsView: UpdateWorkoutPartsView = configureUpdateWorkoutPartsView()
    
    //optionals
    var workout: Workout?
    weak var coordinator: UpdateWorkoutPartsCoordinator?
    var coredateHelper: CoreDataHelper?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViews()
        setupDelegates()
    }
    
    //MARK: - Setups
    
    private func setupViews(){
        view.addSubview(updateWokroutPartsView)
        updateWokroutPartsView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func setupDelegates(){
    }
    
    //MARK: - Actions
    @objc private func updatingDidFinish(){
        updateWokroutPartsView.saveTapped()
    }
    
}

//MARK: - UI Helper Functions
extension UpdateWorkoutPartsController{
    private func configureView(){
        navigationItem.title = "Edit Workout Parts"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updatingDidFinish))
    }
    
    private func configureUpdateWorkoutPartsView()-> UpdateWorkoutPartsView{
        if let workout{
            let view = UpdateWorkoutPartsView(workout)
            view.parentClass = self
            return view
        }
        return UpdateWorkoutPartsView()
    }
}

//MARK: - For Child Methods
extension UpdateWorkoutPartsController{
    func workoutDidUpdate(data: [String: Any]){
        guard let workout, let coredateHelper, let coordinator else{return}
        coredateHelper.update(workout, data: data)
        coordinator.workoutDidSave()
    }
    
    func workoutPartDidSelect(workoutPart: WorkoutPart){
        coordinator?.EditWorkoutPart(workoutPart)
    }
    
    func endUpWithError(message: String){
        UIHelperFunctions.showAlertMessage(message: message) { alert in
            present(alert, animated: true)
        }
    }
}

//MARK: - From Child Methods
extension UpdateWorkoutPartsController{
    func updateWorkoutParts(with workoutPart: WorkoutPart, _ data: [String:Any]){
        updateWokroutPartsView.updateWorkoutParts(with: workoutPart, data)
    }
}
