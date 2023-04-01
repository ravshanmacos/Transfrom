//
//  ProgressTableViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints

class ProgressTableViewController: UIViewController {
    private let tableView = UITableView()
    private let reuseIdentifier = "progressCell"
    var viewModel: ProgressTableviewViewModel?
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
    private func setupViews(){
        
    }
}

extension ProgressTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProgressWorkoutCell
        guard let viewModel else {return cell}
        let workout = viewModel.fetchedResultsController.object(at: indexPath)
        cell.title.text = workout.name
        return cell
    }
}

extension ProgressTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let viewModel else {return}
        viewModel.setSelectedWorkout(with: indexPath)
    }
}
