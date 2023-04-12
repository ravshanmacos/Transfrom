//
//  ProgressTableViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints
import CoreData

class ProgressTableViewController: UIViewController {
    private let tableView = UITableView()
    private let reuseIdentifier = "progressCell"
    var viewModel: ProgressTableviewViewModel?{
        didSet{
            viewModel!.fetchedResultsController?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Workout Progress"
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupTableView(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProgressWorkoutCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

//MARK: - UITableViewDataSource
extension ProgressTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0}
        return viewModel.getWorkoutsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProgressWorkoutCell
        guard let viewModel else {return cell}
        if viewModel.isWorkoutsEmpty(){
            cell.isUserInteractionEnabled = false
        }else {
            cell.isUserInteractionEnabled = true
        }
        let name = viewModel.getWorkoutName(at: indexPath)
        cell.title.text = name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProgressTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel, !viewModel.isWorkoutsEmpty() else {return}
        
        viewModel.setSelectedWorkout(with: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProgressTableViewController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let viewModel else { return }
        viewModel.loadData()
        tableView.reloadData()
    }
}
