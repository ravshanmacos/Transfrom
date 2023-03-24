//
//  CreateWorkoutController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import CoreData

protocol AddWorkoutControllerDelegate: AnyObject{
    func showAlertMessage(message: String)
    func workoutDidCreate(_ name: String, _ duration: Double, _ numberOfParts: Int)
}

class AddWorkoutController: UIViewController {
    
    //MARK: - Properties
    private lazy var createWorkoutView: UIView = {
        let view = AddWorkoutView()
         view.delegate = self
         return view
    }()
    private var workouts:[Workout] = []
    weak var coordinator: AddWorkoutCoordinator?
    var coredataHelper: CoreDataHelper?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setups
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
}

//MARK: - AddWorkoutControllerDelegate
extension AddWorkoutController: AddWorkoutControllerDelegate{
    func workoutDidCreate(_ name: String, _ duration: Double, _ numberOfParts: Int) {
        if duplicating(with: name){
            showAlertMessage(message: "Duplicate Workouts occured, Please enter unique workout name")
            return
        }else{
            let workout = coredataHelper!.create(name, duration, numberOfParts)
            coordinator?.workoutDidCreate(workout)
        }
    }
}

//MARK: - Helper methods
extension AddWorkoutController{
    private func duplicating(with name: String)-> Bool{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "%K == %@", #keyPath(Workout.name), name)
        fetchRequest.predicate = predicate
        let workouts = coredataHelper!.fetchWithPredicate(predicate: predicate)
        if workouts.isEmpty{
         return false
        }
        return true
    }
    
    func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
