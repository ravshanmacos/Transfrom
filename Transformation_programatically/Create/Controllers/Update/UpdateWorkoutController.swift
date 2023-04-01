//
//  UpdateWorkoutController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import CoreData
import TinyConstraints

class UpdateWorkoutController: UIViewController, NSFetchedResultsControllerDelegate {
    //MARK: - Properties
    private lazy var updateWorkoutView: UpdateWorkoutView = configureUpdateWorkoutView()
    
    //optionals
    var coredataHelper: CoreDataHelper?
    var workout: Workout?
    weak var coordinator: UpdateWorkoutCoordinator?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK: - Setups
    private func setupViews(){}
    
    //MARK: - Actions
    @objc private func updatingDidFinish(){
        updateWorkoutView.saveTapped()
    }
}

//MARK: - Update Workout View Delegate methods
extension UpdateWorkoutController{
    func workoutDidUpdate(data: [String: Any]){
        guard let coordinator,let coredataHelper, let workout else{
            print("nil found")
            return}
        coredataHelper.update(workout, data: data)
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

//MARK: - UIHelper Functions
extension UpdateWorkoutController{
    private func configureView(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updatingDidFinish))
        view.addSubview(updateWorkoutView)
        updateWorkoutView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func configureUpdateWorkoutView()-> UpdateWorkoutView{
        if let workout{
            let view = UpdateWorkoutView(workout: workout)
            view.parentClass = self
            return view
        }
        return UpdateWorkoutView()
    }
}

//MARK: - Helper Functions
extension UpdateWorkoutController{
    private func configureWorkout()-> (name: String, duration: Double)?{
        guard let workout, let name = workout.name else{
            print("Workout does not exist");
            return nil
        }
        let data = (name: name, duration: workout.duration)
        return data
    }
    func updateWorkoutParts(with workoutPart: WorkoutPart, _ data: [String:Any]){
        updateWorkoutView.updateWorkoutParts(with: workoutPart, data)
    }
}

