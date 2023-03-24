//
//  ProgressViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints

class ProgressWorkoutController: UIViewController {
    private let dummyData: [String] = ["New York", "New Jersey","California","Texas","Chicago"]
    private let tableView = UITableView()
    private let reuseIdentifier = "progressCell"
    weak var coordinator: WorkoutProgressCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Workout Progress"
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

extension ProgressWorkoutController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProgressWorkoutCell
        cell.title.text = dummyData[indexPath.row]
        return cell
    }
}

extension ProgressWorkoutController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        coordinator?.workoutTypeDidSelect(dummyData[indexPath.row])
    }
}
