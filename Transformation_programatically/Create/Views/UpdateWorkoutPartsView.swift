//
//  UpdateWorkoutPartsView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/24.
//

import UIKit

class UpdateWorkoutPartsView: UIView {
    //MARK: - Properties
    
    //UI properties
    private lazy var tableview = UITableView()
    private let uiComponents = UIComponents.shared
    private let reuseIdentifier = "Cell"
    private lazy var baseSize: CGFloat = Constants.baseSize
    
    private var workoutName = ""
    private var workoutDuration: Double = 0
    private var workoutParts: [WorkoutPart] = []
    weak var parentClass: UpdateWorkoutPartsController?

    //MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this method shoul not be implemented")
    }

    convenience init(_ workout: Workout) {
        self.init(frame: CGRect.zero)
        configureWorkout(workout: workout)
        setupViews()
        setupDelegates()
    }

    //MARK: - Setups
    private func setupViews(){
        let formattedDuration = workoutDuration / 60
        let durationString = "\(formattedDuration)"

        let headerViewTitleField = uiComponents.infoField(title: "Wokout Name", text: workoutName)
        let headerViewDurationField = uiComponents.infoField(type: .withInfo, title: "Total Duration", text: durationString)

        let headerView = uiComponents
            .createStack(axis: .vertical, spacing: 15, fillEqually: true)
        headerView.addArrangedSubviews([headerViewTitleField, headerViewDurationField])
        addSubview(headerView)
        addSubview(tableview)

        headerView.topToSuperview(offset: 20, usingSafeArea: true)
        headerView.leftToSuperview(offset: baseSize * 2)
        headerView.rightToSuperview(offset: -1 * baseSize * 2)

        tableview.topToBottom(of: headerView)
        tableview.leftToSuperview(usingSafeArea: true)
        tableview.rightToSuperview(usingSafeArea: true)
        tableview.bottomToSuperview(usingSafeArea: true)
    }

    private func setupDelegates(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(EditWorkoutPartsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableview.rowHeight = 50
    }
}

//MARK: - UI Helper Methods
extension UpdateWorkoutPartsView{
    func infoField(title: String, text: String)-> UIStackView{
        let titleLabel = uiComponents.createLabel(type: .medium, with: title)
        let textLabel = uiComponents.createLabel(type: .medium, with: text)
        textLabel.textAlignment = .right
        let wrapper = uiComponents.createStack(
            axis: .horizontal, fillEqually: true)
        wrapper.addArrangedSubviews([titleLabel, textLabel])
        return wrapper
    }
}

//MARK: - Helper Functions
extension UpdateWorkoutPartsView{
    private func configureWorkout(workout: Workout){
        guard let name = workout.name, let workoutPartsSet = workout.workoutParts else{return}
        workoutName = name
        workoutDuration = workout.duration
        for workoutPart in workoutPartsSet{
            let part = workoutPart as! WorkoutPart
            workoutParts.append(part)
        }
    }
}

//MARK: - For Parent Methods
extension UpdateWorkoutPartsView{
    
    func saveTapped(){
       let totalDuration = workoutDuration
       let partsDuration = workoutParts.map{$0.duration}.reduce(0, +)
       guard totalDuration == partsDuration else{
            parentClass?.endUpWithError(message: "Overall duration did not match"); return
       }
       let orederedSet = NSOrderedSet(array: workoutParts)
       let data: [String: Any] = [
           "duration": totalDuration,
           "workoutParts": orederedSet
       ]
       parentClass?.workoutDidUpdate(data: data)
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

extension UpdateWorkoutPartsView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutParts.count
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

extension UpdateWorkoutPartsView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{tableview.deselectRow(at: indexPath, animated: true)}
        let workoutPart = workoutParts[indexPath.row]
        parentClass?.workoutPartDidSelect(workoutPart: workoutPart)
    }
}
