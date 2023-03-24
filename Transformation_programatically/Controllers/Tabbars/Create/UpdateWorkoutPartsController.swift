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
    let tableview = UITableView()
    private let uiComponents = UIComponents.shared
    private let reuseIdentifier = "Cell"
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    var workoutName: String = ""
    var workoutDuration: Double = 0
    var workoutParts: [WorkoutPart] = []
    var workout: Workout?{ didSet{ setupWorkouts() } }
    weak var coordinator: UpdateWorkoutPartsCoordinator?
    var coredateHelper: CoreDataHelper?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupViews()
        setupConstraints()
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
    
    private func setupDelegates(){
       // fetchedResultsController?.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(EditWorkoutPartsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableview.rowHeight = 50
    }
    
    private func setupMainView(){
        navigationItem.title = "Edit Workout Parts"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    @objc private func saveTapped(){
        guard let workout, let coredateHelper else{return}
        let totalDuration = workoutDuration
        let partsDuration = workoutParts.map{$0.duration}.reduce(0, +)
        if totalDuration == partsDuration{
            let orederedSet = NSOrderedSet(array: workoutParts)
            let data: [String: Any] = [
                "name": workoutName,
                "duration": totalDuration,
                "workoutParts": orederedSet
            ]
            coredateHelper.update(workout, data: data)
            coordinator?.workoutDidSave()
        }else{
            UIHelperFunctions.showAlertMessage(message: "Overall duration did not match") { alert in
                present(alert, animated: true)
            }
        }
        
    }
    
    private func setupViews(){
        let durationString = "\(workoutDuration) min"
        
        let headerViewTitleField = infoField(title: "Wokout Name", text: workoutName)
        let headerViewDurationField = infoField(title: "Total Duration", text: durationString)
        
        let headerView = uiComponents
            .createStack(axis: .vertical, spacing: 15,
            views: [headerViewTitleField, headerViewDurationField], fillEqually: true)
        view.addSubview(headerView)
        view.addSubview(tableview)
        
        headerView.topToSuperview(offset: 20, usingSafeArea: true)
        headerView.leftToSuperview(offset: baseSize * 2)
        headerView.rightToSuperview(offset: -1 * baseSize * 2)
        
        tableview.topToBottom(of: headerView)
        tableview.leftToSuperview(usingSafeArea: true)
        tableview.rightToSuperview(usingSafeArea: true)
        tableview.bottomToSuperview(usingSafeArea: true)
    }
    private func setupConstraints(){}
}

//MARK: - Helper Methods
extension UpdateWorkoutPartsController{
    func infoField(title: String, text: String)-> UIStackView{
        let titleLabel = uiComponents.createLabel(type: .medium, with: title)
        let textLabel = uiComponents.createLabel(type: .medium, with: text)
        textLabel.textAlignment = .right
        let wrapper = uiComponents.createStack(
            axis: .horizontal,views: [titleLabel, textLabel], fillEqually: true)
        return wrapper
    }
}

//MARK: - UITableViewDataSource

extension UpdateWorkoutPartsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutParts.count
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

extension UpdateWorkoutPartsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{tableview.deselectRow(at: indexPath, animated: true)}
        let workoutPart = workoutParts[indexPath.row]
        coordinator?.EditWorkoutPart(workoutPart)
    }
}
