//
//  CreateWorkoutController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import Combine

class AddWorkoutController: UIViewController {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private let baseFontSize = Constants.baseFontSize
    private let baseSize = Constants.baseSize
    private lazy var workoutTypeTextfield = configureWorkoutTypeTextfield()
    private lazy var datePicker: UIDatePicker = configureDatePicker()
    private lazy var stepper: UIStepper = configureStepper()
    private lazy var stepperLabel:UILabel = configureStepperLabel()
    private lazy var continueBtn: UIButton = configureContinueBtn()
    
    @Published private var stepperCount: Int = 0
    private var cancellables: [AnyCancellable] = []
    var viewModel: AddWorkoutViewModel?
    
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        setupViews()
        setupDelegates()
        setupPublishers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Create Workout"
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Setups
    private func setupPublishers(){
        $stepperCount.sink {[weak self] value in
            self?.stepperLabel.text = String(value)
        }.store(in: &cancellables)
    }
    
    private func setupDelegates(){
        workoutTypeTextfield.delegate = self
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        //setup input field
        let workoutTypeTitle = components.createHeaderTitle(title: "Workout Type")
        let workoutTypeStack = components.createStack(axis: .vertical, spacing: baseSize)
        workoutTypeStack.distribution = .fillProportionally
        
        
        //setup date picker
        let datePickerTitle = components.createHeaderTitle(title: "Workout Duration")
        let datePickerWrapper = components.createStack(axis: .vertical)
        
        //setup division field
        let workoutPartTitle = components.createHeaderTitle(title: "Workout Part")
        let stepperStack = components.createStack(axis: .horizontal,
                                                  spacing: baseSize * 4)
        let workoutPartStack = components.createStack(axis: .vertical,
                                                      spacing: baseSize)
        stepperStack.alignment = .center
        
        //buttons stack
        let buttonsStack = components.createStack()
        buttonsStack.addArrangedSubview(continueBtn)
        
        //adding into view
        stepperStack.addArrangedSubviews([stepperLabel, stepper])
        workoutPartStack.addArrangedSubviews([workoutPartTitle, stepperStack])
        workoutTypeStack.addArrangedSubviews([workoutTypeTitle, workoutTypeTextfield])
        datePickerWrapper.addArrangedSubviews([datePickerTitle, datePicker])
        
        view.addSubviews([workoutTypeStack, datePickerWrapper, workoutPartStack, buttonsStack])
        
        workoutTypeStack.topToSuperview(offset: baseSize * 1, usingSafeArea: true)
        workoutTypeStack.leftToSuperview(offset: baseSize * 2)
        workoutTypeStack.rightToSuperview(offset: -1 * baseSize * 2)
        workoutTypeTextfield.height(50)
        
        datePickerWrapper.topToBottom(of: workoutTypeStack, offset: baseSize * 3)
        datePickerWrapper.leftToSuperview(offset: baseSize * 2)
        datePickerWrapper.rightToSuperview(offset: -1 * baseSize * 2)
        
        workoutPartStack.topToBottom(of: datePickerWrapper, offset: baseSize * 3)
        workoutPartStack.leftToSuperview(offset: baseSize * 2)
        workoutPartStack.rightToSuperview(offset: -1 * baseSize * 2)
        
        buttonsStack.leftToSuperview(offset: baseSize * 2)
        buttonsStack.rightToSuperview(offset: -1 * baseSize * 3)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }
    
    //MARK: - Actions
    @objc private func stepperDidChange(sender: UIStepper){
        stepperCount = Int(sender.value)
    }
    
    @objc private func continueBtnTapped(){
        guard workoutTypeTextfield.hasText,
              stepperCount > 0 else{
            UIHelperFunctions.showAlertMessage(message: "Please choose and fill carefully") { alert in
                present(alert, animated: true)
            }
            return
        }
        let workoutName = workoutTypeTextfield.text!
        let workoutDuration = datePicker.countDownDuration
        guard let viewModel else { return }
        if viewModel.duplicating(with: workoutName){
            UIHelperFunctions.showAlertMessage(message: "Use different name") { alert in
                present(alert, animated: true)
            }
            return
        }
        
        viewModel.workoutDidCreate(workoutName, workoutDuration, stepperCount)
    }
   
}

//MARK: - Configure UI Elements
extension AddWorkoutController{
    func configureWorkoutTypeTextfield()->UITextField{
        let textfield = components.createTexField(placeholder: "Example: Morning Workout")
        textfield.delegate = self
        return textfield
    }
    func configureDatePicker()->UIDatePicker{
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }
    func configureStepper()->UIStepper{
        let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(stepperDidChange), for: .touchUpInside)
        return stepper
     }
    func configureStepperLabel()->UILabel{
        let label = UILabel()
        label.text = String(stepperCount)
        label.font = UIFont.systemFont(ofSize: baseFontSize * 1.5, weight: .medium)
        return label
    }
    func configureContinueBtn()->UIButton{
        let btn = components.createButton(text: "Continue")
        btn.addTarget(self, action: #selector(continueBtnTapped), for: .touchUpInside)
        return btn
    }
}

//MARK: - UITextFieldDelegate
extension AddWorkoutController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dissmissTexfield()
      return true
    }
    
    private func dissmissTexfield(){
        workoutTypeTextfield.endEditing(true)
        workoutTypeTextfield.resignFirstResponder()
    }
}
