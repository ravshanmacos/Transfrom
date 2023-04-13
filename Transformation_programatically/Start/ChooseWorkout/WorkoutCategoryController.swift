//
//  ChooseWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import TinyConstraints
import CoreData
import Combine

class WorkoutCategoryController: UIViewController {
    
    private let components = UIComponents.shared
    private var baseSize = Constants.baseSize
    
    //lazy properties
    private lazy var imageView: UIImageView = configureImageView()
    private lazy var pickerView: UIPickerView = configurePickerView()
    private lazy var startWorkoutButton: UIButton = configureButton()
    
    private var cancellables: [AnyCancellable] = []

    //MARK: - Properties
    var viewModel: WorkoutCategoryViewModel?{
        didSet{
            viewModel!.getFRController()?.delegate = self
        }
    }

    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPublishers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = .bckColor_2
    }
    
    private func setupPublishers(){
        viewModel?.$isWorkoutsEmpty.sink(receiveValue: {[weak self] value in
            guard let self else { return }
            if value {
                startWorkoutButton.backgroundColor = .gray
                startWorkoutButton.isUserInteractionEnabled = false
            }else{
                startWorkoutButton.backgroundColor = .systemBlue
                startWorkoutButton.isUserInteractionEnabled = true
            }
        }).store(in: &cancellables)
    }
    
    //MARK: - Setups Views
    
    private func setupViews(){
        view.backgroundColor = .bckColor_2
        let buttonsStack = components.createStack()
        buttonsStack.addArrangedSubview(startWorkoutButton)
        
        //adding
        view.addSubviews([imageView, pickerView, buttonsStack])
        
        //constrains
        imageView.centerXToSuperview()
        imageView.centerYToSuperview()
        imageView.width(300)
        imageView.height(200)
        
        pickerView.topToBottom(of: imageView)
        pickerView.centerXToSuperview()
        pickerView.height(150)
        
        buttonsStack.leftToSuperview(offset: 20)
        buttonsStack.rightToSuperview(offset: -20)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }
    
    //MARK: - Actions
    @objc private func nextBtnTapped(){
        guard let viewModel else { return }
        viewModel.isNextBtnTapped = true
    }
}

//MARK: - Configuring UI Elements
extension WorkoutCategoryController{
    private func configureImageView()->UIImageView{
        let imageView = UIImageView(image: .pandaLiftingBarbelImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func configurePickerView()-> UIPickerView{
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }
    
    private func configureButton()-> UIButton{
        let button = components.createButton(text: "Start Workout")
        button.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        return button
    }
}

//MARK: - PickerView Datasource and Delegate methods

extension WorkoutCategoryController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let viewModel else { return 0}
        let size = viewModel.getWorkoutsCount()
        return size == 0 ? 1 : size
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let viewModel else {return ""}
        let workoutName = viewModel.getWorkoutName(with: row)
        return workoutName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel else {return}
        viewModel.setSelectedWorkout(row: row)
    }
    
}

//MARK: - NSFetchedResultsControllerDelegate

extension WorkoutCategoryController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let viewModel else { return }
        viewModel.loadData()
        pickerView.reloadAllComponents()
    }
}
