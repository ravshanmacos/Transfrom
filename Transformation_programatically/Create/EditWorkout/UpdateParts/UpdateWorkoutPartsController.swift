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
    private lazy var tableview = UITableView()
    private let uiComponents = UIComponents.shared
    private let reuseIdentifier = "Cell"
    private lazy var baseSize: CGFloat = Constants.baseSize
    var viewModel: UpdateWorkoutPartsViewModel?

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViews()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Setups
    private func setupViews(){
        guard let viewModel else { return }

        let headerViewTitleField = uiComponents
            .infoField(title: "Wokout Name", text: viewModel.getWorkoutName())
        let headerViewDurationField = uiComponents
            .infoField(type: .withInfo, title: "Total Duration", text: String(viewModel.getWorkoutDuration()))
        let headerView = uiComponents
            .createStack(axis: .vertical, spacing: 15, fillEqually: true)
        
        headerView.addArrangedSubviews([headerViewTitleField, headerViewDurationField])
        view.addSubviews([headerView,tableview])

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
    
    
    //MARK: - Actions
    @objc private func updatingDidFinish(){
        guard let viewModel else { return }
        if let error = viewModel.updatingDidFinish() {
            UIHelperFunctions.showAlertMessage(message: error) { alert in
                present(alert, animated: true)
            }
        }
    }
}

//MARK: - Configuring UI
extension UpdateWorkoutPartsController{
    private func configureView(){
        navigationItem.title = "Edit Workout Parts"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updatingDidFinish))
    }
    
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

//MARK: - UITableViewDataSource

extension UpdateWorkoutPartsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return 0}
        
        return viewModel.getWorkoutPartsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as! EditWorkoutPartsCell
        guard let viewModel else { return cell}
        let workoutPart = viewModel.getWorkoutPart(at: indexPath)
        cell.title.text = workoutPart.name
        cell.secondaryTitle.text = "\(workoutPart.duration/60) minutes"
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
        guard let viewModel else { return }
        viewModel.setSelectedWorkoutPart(by: indexPath)
    }
    
    func updateWorkoutParts(with workoutPart: WorkoutPart, data: [String: Any]){
        guard let viewModel else {return}
        viewModel.updateWorkoutParts(workoutPart, data: data)
        tableview.reloadData()
    }
}
