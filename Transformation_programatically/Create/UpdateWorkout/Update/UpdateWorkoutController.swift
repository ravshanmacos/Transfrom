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
    //Lazy UI Elements
    private lazy var tableview = configureTableView()
    private lazy var headerView = UIView()
    private lazy var nameField: UITextField = configureNameField()
    private lazy var durationField: UITextField = configureDurationField()
   
    // Constants
    private let uiComponents = UIComponents.shared
    private let reuseIdentifier = "Cell"
    var viewModel: UpdateWorkoutViewModel?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainView()
        configureMainView()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Setups
    
    func setupViews(){
        //attributes
        let headerWrapper = UIView()
        let mainWrapper = uiComponents.createStack(axis: .vertical, spacing: 0)
        let workoutNameField = uiComponents.infoTextField(title: "Workout Name", textfield: nameField)
        let workoutDurationField = uiComponents.infoTextField(type: .withInfo,title: "Total Duration", textfield: durationField)
        let fieldWrapper = uiComponents.createStack(axis: .vertical,spacing: 10, fillEqually: true)
       
        
        //adding
        fieldWrapper.addArrangedSubviews([workoutNameField, workoutDurationField])
        headerWrapper.addSubview(fieldWrapper)
        mainWrapper.addArrangedSubviews([headerWrapper, tableview])
        view.addSubview(mainWrapper)
        
        //constraints
        fieldWrapper.edgesToSuperview(
            insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        mainWrapper.edgesToSuperview(
            insets: TinyEdgeInsets(top: 10, left: 0, bottom: 10, right: 0) ,usingSafeArea: true)
    }
    
    //MARK: - Actions
    @objc private func updatingDidFinish(){
        guard let viewModel, let FRController = viewModel.fetchedResultsController,
                let workoutParts = FRController.fetchedObjects else {return}
        
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
            UIHelperFunctions.showAlertMessage(message: "Overall duration did not match") { alert in
                present(alert, animated: true)
            }
            return
        }
        let orederedSet = NSOrderedSet(array: workoutParts)
        let data: [String: Any] = [
            "name": editedWorkoutName,
            "duration": editedWorkoutDuration,
            "workoutParts": orederedSet
        ]
        viewModel.workoutDidUpdate(data: data)
    }
}

//MARK: - Configuring UI Elements
extension UpdateWorkoutController{
    private func configureMainView(){
        view.backgroundColor = .bckColor_4
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self, action: #selector(updatingDidFinish))
    }
    
    private func configureTableView()->UITableView{
        let tableview = UITableView()
        tableview.backgroundColor = .bckColor_4
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(EditWorkoutPartsCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableview
    }
    
    private func configureNameField()-> UITextField{
        let textField = UITextField()
        textField.placeholder = "Enter workout name"
        if let viewModel { textField.text = viewModel.getWorkoutName() }
        return textField
    }
    private func configureDurationField()-> UITextField{
        let textField = UITextField()
         textField.keyboardType = .numberPad
         textField.placeholder = "Enter workout duration"
        if let viewModel { textField.text = viewModel.getWorkoutDuration() }
         return textField
    }
}

//MARK: - UITableViewDataSource
extension UpdateWorkoutController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getWorkoutPartsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        as! EditWorkoutPartsCell
        guard let workoutPart = viewModel?.getWorkout(indexPath) else {return cell}
        cell.title.text = workoutPart.name
        cell.secondaryTitle.text = "\(workoutPart.duration/60) min"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Workout Parts"
    }
}

//MARK: - Delegates
extension UpdateWorkoutController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {tableview.deselectRow(at: indexPath, animated: true)}
        guard let viewModel, let workoutPart = viewModel.getWorkout(indexPath) else {return}
        viewModel.workoutPartDidSelect(workoutPart: workoutPart)
    }
    
    func updateWorkoutParts(with workoutPart: WorkoutPart, data: [String: Any]){
        guard let viewModel else {return}
        viewModel.updateWorkoutParts(workoutPart, data: data)
        tableview.reloadData()
    }
}
