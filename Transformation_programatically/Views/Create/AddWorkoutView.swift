//
//  CreateWorkoutView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints
import Combine
import CoreData

class AddWorkoutView: UIView {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private var baseFontSize: CGFloat {
        return Constants.baseFontSize
    }
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    
    private lazy var workoutTypeTextfield = {
        return components.createTexField(placeholder: "Example: Morning Workout")
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()
    
    private lazy var stepper: UIStepper = {
       let stepper = UIStepper()
        stepper.addTarget(self, action: #selector(stepperDidChange), for: .touchUpInside)
       return stepper
    }()
    
    private lazy var stepperLabel:UILabel = {
        let label = UILabel()
        label.text = String(stepperCount)
        label.font = UIFont.systemFont(ofSize: baseFontSize * 1.5, weight: .medium)
        return label
    }()
    
    private lazy var continueBtn: UIButton = {
        let btn = components.createButton(text: "Continue")
        btn.addTarget(self, action: #selector(continueBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    @Published private var stepperCount: Int = 0
    private var cancellables: [AnyCancellable] = []
    var delegate: AddWorkoutControllerDelegate?
    
    
    //MARK: - LifeCycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupDelegates()
        setupPublishers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this view should not be implemented from storyboard")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupDelegates()
    }
    
    private func setupPublishers(){
        $stepperCount.sink {[weak self] value in
            self?.stepperLabel.text = String(value)
        }.store(in: &cancellables)
    }
    
    //MARK: - Actions
    @objc private func stepperDidChange(sender: UIStepper){
        stepperCount = Int(sender.value)
    }
    
    @objc private func continueBtnTapped(){
        guard workoutTypeTextfield.hasText,
              stepperCount > 0 else{
            delegate?.showAlertMessage(message: "Please choose and fill carefully")
            return
        }
        let workoutName = workoutTypeTextfield.text!
        let workoutDuration = datePicker.countDownDuration
        delegate?.workoutDidCreate(workoutName, workoutDuration, stepperCount)
    }
}

//MARK: - Setups
extension AddWorkoutView{
    private func setupDelegates(){
        workoutTypeTextfield.delegate = self
    }
    
    private func setupViews(){
        //setup input field
        let workoutTypeTitle = components.createHeaderTitle(title: "Workout Type")
        let workoutTypeStack = components.createStack(axis: .vertical, spacing: baseSize,
                                                      views: [workoutTypeTitle, workoutTypeTextfield])
        workoutTypeStack.distribution = .fillProportionally
        
        
        //setup date picker
        let datePickerTitle = components.createHeaderTitle(title: "Workout Duration")
        let datePickerWrapper = components.createStack(axis: .vertical,
                                                       views: [datePickerTitle, datePicker])
        
        //setup division field
        let workoutPartTitle = components.createHeaderTitle(title: "Workout Part")
        let stepperStack = components.createStack(axis: .horizontal,
                                                  spacing: baseSize * 4,
                                                  views: [stepperLabel, stepper])
        let workoutPartStack = components.createStack(axis: .vertical,
                                                      spacing: baseSize,
                                                       views: [workoutPartTitle, stepperStack])
        stepperStack.alignment = .center
        
        //buttons stack
        let buttonsStack = components.createStack()
        buttonsStack.addArrangedSubview(continueBtn)
        
        //adding into view
        [workoutTypeStack, datePickerWrapper, workoutPartStack, buttonsStack].forEach{addSubview($0)}
        
        workoutTypeStack.topToSuperview(offset: baseSize * 3)
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
}

//MARK: - UITextFieldDelegate
extension AddWorkoutView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dissmissTexfield()
      return true
    }
    
    private func dissmissTexfield(){
        workoutTypeTextfield.endEditing(true)
        workoutTypeTextfield.resignFirstResponder()
    }
}
