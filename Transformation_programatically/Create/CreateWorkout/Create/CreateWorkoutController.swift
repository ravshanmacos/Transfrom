//
//  CreateWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import TinyConstraints
import CoreData

class CreateWorkoutController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Properties
    private let baseSize = Constants.baseSize
    private let baseFontSize = Constants.baseFontSize
    private let uiComponents = UIComponents.shared
    private lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    private lazy var addWorkoutBtn: UIButton = {
        let button = uiComponents.createButton(text: "Add Workout")
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel: CreateWorkoutViewModel?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Setups
    private func setupViews(){
        view.backgroundColor = .white
        let verticalStack = uiComponents.createStack(axis: .vertical, spacing: 0)
        
        //Inserting
        headerView.addSubview(addWorkoutBtn)
        verticalStack.addArrangedSubviews([tableView, headerView])
        view.addSubview(verticalStack)
        
        //constraints
        headerView.height(60)
        addWorkoutBtn.edgesToSuperview(insets: TinyEdgeInsets(
            top: baseSize / 2,left: baseSize * 2, bottom: baseSize / 2, right: baseSize * 2))
        verticalStack.edgesToSuperview(insets: TinyEdgeInsets(top: 0, left: 0, bottom: baseSize * 2, right: 0), usingSafeArea: true)
    }
    
    private func setupDelegates(){
        if let viewModel {viewModel.fetchedResultsController.delegate = self}
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "workoutCell")
    }
    
    //MARK: - Actions
    @objc private func addTapped(){
        guard let viewModel else {return}
        viewModel.addWorkoutDidTap()
    }
}

//MARK: - UITableView Datasource
extension CreateWorkoutController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath)
        guard let viewModel else {return cell}
        let workout = viewModel.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = workout.name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CreateWorkoutController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{tableView.deselectRow(at: indexPath, animated: true)}
        guard let viewModel else {return}
        let workout = viewModel.fetchedResultsController.object(at: indexPath)
        viewModel.workoutDidSelect(workout)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, let viewModel else {return}
        let workout = viewModel.fetchedResultsController.object(at: indexPath)
        viewModel.workoutDidDelete(workout)
        tableView.reloadData()
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension CreateWorkoutController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}



