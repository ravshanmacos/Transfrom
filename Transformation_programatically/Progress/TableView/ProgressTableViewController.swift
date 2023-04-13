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
    private lazy var imageView = configureImageView()
    private lazy var tableView = configureTableView()
    private let reuseIdentifier = "progressCell"
    var viewModel: ProgressTableviewViewModel?{
        didSet{
            viewModel!.fetchedResultsController?.delegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        configureMainUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Workout Progress"
        tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = .white
    }
    
    private func setupTableView(){
        view.addSubviews([imageView, tableView])
        
        imageView.centerYToSuperview(multiplier: 0.7)
        imageView.centerXToSuperview()
        imageView.width(300)
        imageView.height(200)
        
        tableView.topToBottom(of: imageView, offset: 20)
        tableView.leftToSuperview(offset: 20,usingSafeArea: true)
        tableView.rightToSuperview(offset: -20,usingSafeArea: true)
        tableView.bottomToSuperview(offset: -20,usingSafeArea: true)
    }
}

//MARK: - UITableViewDataSource
extension ProgressTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0}
        return viewModel.getWorkoutsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableViewCell
        cell.configureCellUI(.bckColor_3)
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

//MARK: - Configure UI Elements

extension ProgressTableViewController{
    private func configureMainUI(){
        view.backgroundColor = .bckColor_3
        tableView.backgroundColor = .bckColor_3
    }
    
    private func configureImageView()->UIImageView{
        let imageView = UIImageView(image: .pandaExhaustedImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func configureTableView()->UITableView{
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
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
