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
    
    private lazy var imageView: UIImageView = configureImageView()
    private lazy var tableView: UITableView = configureTableView()
    private lazy var addWorkoutBtn: UIButton = configureAddWorkoutBtn()
    
    var viewModel: CreateWorkoutViewModel?{
        didSet{
            viewModel?.fetchedResultsController?.delegate = self
        }
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = .white
    }
    
    //MARK: - Setups
    private func setupViews(){
        //Inserting
        view.addSubviews([imageView, tableView, addWorkoutBtn])
        
        //imageView Constraints
        imageView.centerXToSuperview()
        imageView.centerYToSuperview(multiplier: 0.7)
        imageView.width(250)
        imageView.height(250)
        
        //tableView Constraints
        tableView.topToBottom(of: imageView)
        tableView.leftToSuperview()
        tableView.rightToSuperview()
        tableView.bottomToTop(of: addWorkoutBtn)
        
        //addWorkoutBtn Constraints
        addWorkoutBtn.height(50)
        addWorkoutBtn.leftToSuperview(offset: 20)
        addWorkoutBtn.rightToSuperview(offset: -20)
        addWorkoutBtn.bottomToSuperview(offset: -20, usingSafeArea: true)
        
    }
    
    //MARK: - Actions
    @objc private func addTapped(){
        guard let viewModel else {return}
        viewModel.addWorkoutDidTap()
    }
}

//MARK: - Configuring UI Elements
extension CreateWorkoutController{
    private func configureMainUI(){
        view.backgroundColor = .bckColor_4
    }
    
    private func configureImageView()->UIImageView{
        let imageView = UIImageView(image: .pandaLyingImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func configureTableView()->UITableView{
        let tableView = UITableView()
        tableView.backgroundColor = .bckColor_4
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "workoutCell")
        return tableView
    }
    
    private func configureAddWorkoutBtn()->UIButton{
        let button = UIButton()
        button.setTitle("Add Workout", for: .normal)
        button.backgroundColor = .btnBckColor_1
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }
    
}

//MARK: - UITableView Datasource
extension CreateWorkoutController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! CustomTableViewCell
        cell.configureCellUI(.bckColor_4)
        guard let viewModel else {return cell}
        let workout = viewModel.fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = workout?.name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CreateWorkoutController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{tableView.deselectRow(at: indexPath, animated: true)}
        guard let viewModel else {return}
        guard let workout = viewModel.fetchedResultsController?.object(at: indexPath) else {return}
        viewModel.workoutDidSelect(workout)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, let viewModel else {return}
        guard let workout = viewModel.fetchedResultsController?.object(at: indexPath) else {return}
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



