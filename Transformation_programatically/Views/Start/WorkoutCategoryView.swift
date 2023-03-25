//
//  workoutCategoryView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints
import CoreData

class WorkoutCategoryView: UIView {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private var baseSize = Constants.baseSize
    
    //lazy properties 
    private lazy var pickerView: UIPickerView = configurePickerView()
    private lazy var startWorkoutButton: UIButton = configureButton()
    
    //optionals
    private var selectedWorkout: Workout?
    private var fetchedResultsController: NSFetchedResultsController<Workout>?
    weak var delegate: WorkoutCategoryDelegate?
  
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this should be implemented storyboard")
    }
    
    convenience init(_ fetchedResultsController: NSFetchedResultsController<Workout>?) {
        self.init(frame: CGRect.zero)
        self.fetchedResultsController = fetchedResultsController
        fetchedResultsController?.delegate = self
        loadData()
        setupDelegates()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Actions
    @objc private func startTapped(){
        guard let selectedWorkout else{
            guard let fetchedResultsController else{return}
            let indexPath = IndexPath(row: 0, section: 0)
            let workout = fetchedResultsController.object(at: indexPath)
            delegate?.workoutDidSelect(workout)
            return
        }
        delegate?.workoutDidSelect(selectedWorkout)
    }
    
    private func loadData(){
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("failed to load objects \(error.localizedDescription)")
        }
    }
    
    //MARK: - Setups
    private func setupDelegates(){
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setupViews(){
        backgroundColor = .white
        let buttonsStack = components.createStack()
        buttonsStack.addArrangedSubview(startWorkoutButton)
        
        //adding
        [pickerView, buttonsStack].forEach{addSubview($0)}
        
        //constrains
        pickerView.centerInSuperview()
        buttonsStack.leftToSuperview(offset: 20)
        buttonsStack.rightToSuperview(offset: -20)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }
    private func setupConstraints(){}
}

//MARK: - UI Helper Functions
extension WorkoutCategoryView{
    private func configurePickerView()-> UIPickerView{
        let pickerView = UIPickerView()
        return pickerView
    }
    
    private func configureButton()-> UIButton{
        let button = components.createButton(text: "Start Workout")
//        if data.isEmpty{
//            button.isEnabled = false
//            button.backgroundColor = UIColor.white
//            button.layer.borderWidth = 1
//            button.layer.borderColor = UIColor.lightGray.cgColor
//            button.setTitleColor(UIColor.lightGray, for: .normal)
//        }
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }
}

//MARK: - PickerView Datasource and Delegate methods

extension WorkoutCategoryView: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let fetchedResultsController else{
            print("fetchedResultsController nil")
            return 0
        }
        
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else{
            print("fetched object is nil")
            return 0
        }
        return fetchedObjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        guard let fetchedResultsController, let fetchedObjects = fetchedResultsController.fetchedObjects else{return ""}
        guard fetchedObjects.count != 0 else{
            return "is empty"
        }
        let indexPath = IndexPath(row: row, section: 0)
        let workout = fetchedResultsController.object(at: indexPath)
        
        return workout.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let fetchedResultsController else{
            return
        }
        let indexPath = IndexPath(row: row, section: 0)
        let workout = fetchedResultsController.object(at: indexPath)
        selectedWorkout = workout
    }
    
}

//MARK: - NSFetchedResultsControllerDelegate

extension WorkoutCategoryView: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        pickerView.reloadAllComponents()
    }
}


