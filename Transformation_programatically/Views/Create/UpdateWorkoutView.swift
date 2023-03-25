//
//  UpdateWorkoutView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/24.
//

import UIKit
import TinyConstraints

class UpdateWorkoutView: UIView {
    //MARK: - Properties
    
    //Lazy UI Elements
    private lazy var tableview = UITableView()
    private lazy var headerView = UIView()
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter workout name"
        return textField
    }()
    private lazy var durationField: UITextField = {
       let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Enter workout duration"
        return textField
    }()
   
    // Constants
    private let uiComponents = UIComponents.shared
    private let reuseIdentifier = "Cell"
    private var workoutParts: [WorkoutPart] = []
    
    //variables
    weak var parentClass: UpdateWorkoutController?
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupViews()
        setupDelegates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this view should not be implemented from storyboard")
    }
    
    convenience init(workout: Workout) {
        self.init(frame: CGRect.zero)
        configureWorkout(workout: workout)
    }
    
    //MARK: - Setups
    
    func setupViews(){
        //attributes
        let headerWrapper = UIView()
        let workoutNameField = uiComponents.infoTextField(title: "Workout Name", textfield: nameField)
        let workoutDurationField = uiComponents.infoTextField(type: .withInfo,title: "Total Duration", textfield: durationField)
        
        
        //adding
        let fieldWrapper = uiComponents.createStack(axis: .vertical,spacing: 10,
            views: [workoutNameField, workoutDurationField],
            fillEqually: true)
        headerWrapper.addSubview(fieldWrapper)
        let mainWrapper = uiComponents.createStack(axis: .vertical, spacing: 0, views: [headerWrapper, tableview])
        addSubview(mainWrapper)
        
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
    
    //MARK: - Actions
    
    func saveTapped(){
        guard let editedWorkoutName = nameField.text, let editedWorkoutDurationString = durationField.text
        else{
            print("nil found"); return
        }
        guard !editedWorkoutName.isEmpty, !editedWorkoutDurationString.isEmpty else{
            print("fields are empty"); return
        }
        var editedWorkoutDuration = Double(editedWorkoutDurationString)!
        editedWorkoutDuration = editedWorkoutDuration * 60
        let partsDuration = workoutParts.map{$0.duration}.reduce(0, +)
        guard editedWorkoutDuration == partsDuration else{
            parentClass?.endUpWithError(message: "Overall duration did not match")
            return
        }
        let orederedSet = NSOrderedSet(array: workoutParts)
        let data: [String: Any] = [
            "name": editedWorkoutName,
            "duration": editedWorkoutDuration,
            "workoutParts": orederedSet
        ]
        parentClass?.workoutDidUpdate(data: data)
    }
}

//MARK: - UIHelper  Functions
extension UpdateWorkoutView{
    private func configureView(){}
}

//MARK: - Helper Functions
extension UpdateWorkoutView{
    private func configureWorkout(workout: Workout){
        guard let name = workout.name, let workoutPartsSet = workout.workoutParts else{return}
        print(workout.duration)
        nameField.text = name
        durationField.text = String(workout.duration / 60)
        for workoutPart in workoutPartsSet{
            let part = workoutPart as! WorkoutPart
            workoutParts.append(part)
        }
    }
    
    func updateWorkoutParts(with workoutPart: WorkoutPart, _ data: [String:Any]){
        let index = workoutParts.firstIndex(of: workoutPart)!
        workoutParts.remove(at: index)
        workoutPart.name = (data["name"] as! String)
        workoutPart.duration = data["duration"] as! Double
        workoutParts.insert(workoutPart, at: index)
        tableview.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension UpdateWorkoutView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        as! EditWorkoutPartsCell
        let workoutPart = workoutParts[indexPath.row]
        cell.title.text = workoutPart.name
        cell.secondaryTitle.text = "\(workoutPart.duration/60) minutes"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Workout Parts"
    }
}

//MARK: - UITableViewDelegate
extension UpdateWorkoutView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {tableview.deselectRow(at: indexPath, animated: true)}
        let workoutPart = workoutParts[indexPath.row]
        parentClass?.workoutPartDidSelect(workoutPart: workoutPart)
    }
}
