//
//  EditWorkoutPartController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/04.
//

import UIKit

class EditWorkoutPartController: UIViewController {
    
    //MARK: - Properties
    private let uiComponents = UIComponents.shared
    private var baseFontSize = Constants.baseFontSize
    private var baseSize = Constants.baseSize
    private lazy var workoutPartTextfield = configureWorkoutPartTextfield()
    private lazy var datePicker: UIDatePicker = configureDatePicker()
    private lazy var doneBtn: UIButton = configureDoneButton()
    var viewModel: EditWorkoutPartViewModel?{
        didSet{
            configure(viewModel!)
        }
    }

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Setups
    private func setupViews(){
        view.backgroundColor = .white
        //setup input field
        let workoutTypeTitle = uiComponents.createHeaderTitle(title: "Workout Type")
        let workoutTypeStack = uiComponents.createStack(axis: .vertical, spacing: baseSize)
        workoutTypeStack.distribution = .fillProportionally
        
        //setup date picker
        let datePickerTitle = uiComponents.createHeaderTitle(title: "Workout Duration")
        let datePickerWrapper = uiComponents.createStack(axis: .vertical)
        let buttonsStack = uiComponents.createStack()
        
        //adding
        buttonsStack.addArrangedSubview(doneBtn)
        workoutTypeStack.addArrangedSubviews([workoutTypeTitle, workoutPartTextfield])
        datePickerWrapper.addArrangedSubviews([datePickerTitle, datePicker])
        view.addSubviews([workoutTypeStack, datePickerWrapper, buttonsStack])
        
        //Constraints
        workoutTypeStack.topToSuperview(offset: baseSize * 3)
        workoutTypeStack.leftToSuperview(offset: baseSize * 2)
        workoutTypeStack.rightToSuperview(offset: baseSize * -2)
        workoutPartTextfield.height(50)
        
        datePickerWrapper.topToBottom(of: workoutTypeStack, offset: baseSize * 3)
        datePickerWrapper.leftToSuperview(offset: baseSize * 2)
        datePickerWrapper.rightToSuperview(offset: baseSize * -2)
        
        buttonsStack.leftToSuperview(offset: baseSize * 2)
        buttonsStack.rightToSuperview(offset: baseSize * -3)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }
    
    private func setupDelegates(){
        workoutPartTextfield.delegate = self
    }
    
    //MARK: - Actions
    @objc private func doneBtnTapped(){
        guard let workoutPartName = workoutPartTextfield.text else{return}
        let duration = datePicker.countDownDuration
        let data:[String: Any] = ["name": workoutPartName, "duration": duration]
        guard let viewModel else { return }
        viewModel.saveTapped(data)
    }
}

//MARK: - UI Configuring Methods
extension EditWorkoutPartController{
    private func configureWorkoutPartTextfield()->UITextField{
        let textfield = uiComponents.createTexField(placeholder: "Example: Morning Workout")
        return textfield
    }
    
    private func configureDatePicker()-> UIDatePicker{
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }
    
    private func configureDoneButton()->UIButton{
        let btn = uiComponents.createButton(text: "Done")
        btn.addTarget(self, action: #selector(doneBtnTapped), for: .touchUpInside)
        return btn
    }
}

//MARK: - Configuring methods
extension EditWorkoutPartController{
    private func configure(_ model: EditWorkoutPartViewModel){
        workoutPartTextfield.text = model.getWorkoutPartName()
        datePicker.countDownDuration = model.getWorkoutPartDuration()
    }
}

//MARK: - UITextFieldDelegate
extension EditWorkoutPartController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dissmissTexfield()
      return true
    }
    
    private func dissmissTexfield(){
        workoutPartTextfield.endEditing(true)
        workoutPartTextfield.resignFirstResponder()
    }
}
