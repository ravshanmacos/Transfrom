//
//  EditWorkoutPartsController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit

class EditWorkoutPartsController: UIViewController {
    
    private let tableview = UITableView()
    private let components = UIComponents.shared
    private let reuseIdentifier = "Cell"
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    var workout: WorkoutModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    private func setupDelegates(){
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
        print("save Tapped")
    }
    
    private func setupViews(){
        
        let headerView = UIStackView()
        headerView.distribution = .fillEqually
        headerView.axis = .horizontal
        let headerViewTitle = components.createLabel(type: .medium, with: "Total Workout Duration")
        headerViewTitle.textAlignment = .left
        let headerViewSecondaryTitle = components.createLabel(type: .medium, with: "\(workout.duration / 60) minutes")
        headerViewSecondaryTitle.textAlignment = .right
        
        headerView.addArrangedSubview(headerViewTitle)
        headerView.addArrangedSubview(headerViewSecondaryTitle)
        view.addSubview(headerView)
        view.addSubview(tableview)
        
        headerView.topToSuperview(usingSafeArea: true)
        headerView.leftToSuperview(offset: baseSize * 2)
        headerView.rightToSuperview(offset: -1 * baseSize * 2)
        headerView.height(50)
        
        tableview.topToBottom(of: headerView)
        tableview.leftToSuperview(usingSafeArea: true)
        tableview.rightToSuperview(usingSafeArea: true)
        tableview.bottomToSuperview(usingSafeArea: true)
    }
    private func setupConstraints(){
        
    }

}

extension EditWorkoutPartsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workout.workoutParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditWorkoutPartsCell
        cell.title.text = workout.workoutParts[indexPath.row].name
        let workoutPartDuration = workout.workoutParts[indexPath.row].duration
        cell.secondaryTitle.text = "\(workoutPartDuration) minutes"
        return cell
    }
}

extension EditWorkoutPartsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let workoutPart = workout.workoutParts[indexPath.row]
        let editWorkoutPartController = EditWorkoutPartController()
        editWorkoutPartController.workoutPart = workoutPart
        present(editWorkoutPartController, animated: true)
    }
}
