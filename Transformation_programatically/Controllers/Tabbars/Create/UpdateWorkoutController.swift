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
    private let uiComponents = UIComponents.shared
    private let reuseIdentifier = "Cell"
    var tableview = UITableView()
    private lazy var headerView = UIView()
    private lazy var workoutNameTextfield: UITextField = uiComponents.createTexField(placeholder: "Enter workout name", text: workoutName)
    private lazy var workoutDurationTextfield: UITextField = uiComponents.createTexField(placeholder: "Enter workout duration", text: "\(workoutDuration) min")
    
    var workoutName: String = ""
    var workoutDuration: Double = 0
    var workoutParts: [WorkoutPart] = []
    var coredataHelper: CoreDataHelper?
    var workout: Workout?{ didSet{ setupWorkouts() } }
    weak var coordinator: UpdateWorkoutCoordinator?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
    }
    
    private func setupWorkouts(){
        guard let workout = workout,let name = workout.name,
              let workoutPartsSet = workout.workoutParts else {return}
        workoutName = name
        workoutDuration = workout.duration / 60
        for workoutPart in workoutPartsSet{
            let part = workoutPart as! WorkoutPart
            workoutParts.append(part)
        }
    }
    
    //MARK: - Setups
    func setupViews(){
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneTapped))
        //attributes
        let workoutNameField = infoField(title: "Workout Name", textfield: workoutNameTextfield)
        let workoutDurationField = infoField(title: "Total Duration", textfield: workoutDurationTextfield)
        
        
        //adding
        let fieldWrapper = uiComponents.createStack(
            axis: .vertical,
            spacing: 10,
            views: [workoutNameField, workoutDurationField],
            fillEqually: true)
        let headerWrapper = UIView()
        headerWrapper.addSubview(fieldWrapper)
        let mainWrapper = uiComponents.createStack(
            axis: .vertical, spacing: 0, views: [headerWrapper, tableview])
        view.addSubview(mainWrapper)
        
        //constraints
        fieldWrapper.edgesToSuperview(
            insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        mainWrapper.edgesToSuperview(
            insets: TinyEdgeInsets(top: 10, left: 0, bottom: 10, right: 0) ,usingSafeArea: true)
    }
    
    func setupDelegates(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(EditWorkoutPartsCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc private func doneTapped(){
        guard let workout, let coredataHelper, let totalDuration = workoutDurationTextfield.text,
        let stringDuration = totalDuration.first, let doubleDuration = Double(stringDuration.description)
        else{return}
        
        let partsDuration = workoutParts.map{$0.duration}.reduce(0, +)
        print(totalDuration, partsDuration)
        if doubleDuration == partsDuration{
            let orederedSet = NSOrderedSet(array: workoutParts)
            guard let stringDuration = workoutDurationTextfield.text,
                  let clippedDuration = stringDuration.first,
                  let doubleDuration = Double(clippedDuration.description)
            else{return}
            
            let submittableDuration = doubleDuration * 60
            let data: [String: Any] = [
                "name": workoutNameTextfield.text!,
                "duration": submittableDuration,
                "workoutParts": orederedSet
            ]
            coredataHelper.update(workout, data: data)
            coordinator?.workoutDidSave()
        }else{
            UIHelperFunctions.showAlertMessage(message: "Overall duration did not match") { alert in
                present(alert, animated: true)
            }
        }
    }
}

//MARK: - Seperate Functions
extension UpdateWorkoutController{
    func infoField(title: String, textfield: UITextField)-> UIStackView{
        let titleLabel = uiComponents.createLabel(type: .medium, with: title)
        textfield.textAlignment = .right
        let wrapper = uiComponents.createStack(
            axis: .horizontal,views: [titleLabel, textfield], fillEqually: true)
        return wrapper
    }
}

//MARK: - UITableViewDataSource
extension UpdateWorkoutController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        as! EditWorkoutPartsCell
        let workoutPart = workoutParts[indexPath.row]
        cell.title.text = workoutPart.name
        cell.secondaryTitle.text = "\(workoutPart.duration) minutes"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Workout Parts"
    }
}

//MARK: - UITableViewDelegate
extension UpdateWorkoutController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {tableview.deselectRow(at: indexPath, animated: true)}
        let workoutPart = workoutParts[indexPath.row]
        coordinator?.EditWorkoutPart(workoutPart)
    }
}
