//
//  CreateWorkoutView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/21.
//

import UIKit
import CoreData
import TinyConstraints

class CreateWorkoutView: UIView{
    
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
    private var fetchedResultsController: NSFetchedResultsController<Workout>?
    weak var delegate: CreateWorkoutControllerDelegate?
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this should be implemented storyboard")
    }
    
    convenience init(fetchedResultsController: NSFetchedResultsController<Workout>) {
        self.init(frame: CGRect.zero)
        self.fetchedResultsController = fetchedResultsController
        fetchedResultsController.delegate = self
        setupViews()
        setupDelegates()
    }
    
    //MARK: - Setups
    private func setupViews(){
        let verticalStack = uiComponents.createStack(axis: .vertical, spacing: 0, views: [tableView, headerView])
        
        //Inserting
        headerView.addSubview(addWorkoutBtn)
        addSubview(verticalStack)
        
        //constraints
        headerView.height(60)
        addWorkoutBtn.edgesToSuperview(insets: TinyEdgeInsets(
            top: baseSize / 2,left: baseSize * 2, bottom: baseSize / 2, right: baseSize * 2))
        verticalStack.edgesToSuperview(insets: TinyEdgeInsets(top: 0, left: 0, bottom: baseSize * 2, right: 0))
    }
    
    private func setupDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "workoutCell")
    }
    
    //MARK: - Actions
    @objc private func addTapped(){
        delegate?.addTapped()
    }
}

//MARK: - UITableView Datasource
extension CreateWorkoutView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath)
        let workout = fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = workout?.name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CreateWorkoutView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let workout = fetchedResultsController?.object(at: indexPath) else{return}
        delegate?.workoutDidSelect(workout)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
              let workout = fetchedResultsController?.object(at: indexPath) else {return}
        delegate?.workoutDidDelete(workout)
        tableView.reloadData()
    }
}

//MARK: - NSFetchedResultsControllerDelegate

extension CreateWorkoutView: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
