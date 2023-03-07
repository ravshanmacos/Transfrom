//
//  CreateWorkoutView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints
import Combine

class CreateWorkoutView: UIView {
    
    //MARK: - Properties
    private var baseFontSize: CGFloat {
        return Constants.baseFontSize
    }
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    
    private lazy var workoutTypeTextfield = {
        return createTexField(placeholder: "Example: Morning Workout")
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
        let btn = CustomButton.shared.createButton(type: .filled, text: "Continue", state: true)
        btn.addTarget(self, action: #selector(continueBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    @Published private var stepperCount: Int = 0
    private var cancellables: [AnyCancellable] = []
    var delegate: CreateWorkoutControllerDelegate?
    
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
    
    @objc private func stepperDidChange(sender: UIStepper){
        stepperCount = Int(sender.value)
    }
    
    @objc private func continueBtnTapped(){
        guard workoutTypeTextfield.hasText,
              stepperCount > 0 else{
            delegate?.showAlertMessage(message: "Please choose and fill carefully")
            return
        }
        let workoutType = workoutTypeTextfield.text!
        let workoutDuration = datePicker.countDownDuration
        let workoutParts = stepperCount
        
    }
    
    private func setupDelegates(){
        workoutTypeTextfield.delegate = self
    }
    
    private func setupViews(){
        //setup input field
        let workoutTypeStack = createStack(axis: .vertical, spacing: baseSize)
        workoutTypeStack.distribution = .fillProportionally
        let workoutTypeTitle = createHeaderTitle(title: "Workout Type")
        workoutTypeTextfield.becomeFirstResponder()
        workoutTypeStack.addArrangedSubview(workoutTypeTitle)
        workoutTypeStack.addArrangedSubview(workoutTypeTextfield)
        
        //setup date picker
        let datePickerTitle = createHeaderTitle(title: "Workout Duration")
        let datePickerWrapper = createStack(axis: .vertical)
        datePickerWrapper.addArrangedSubview(datePickerTitle)
        datePickerWrapper.addArrangedSubview(datePicker)
        
        //setup division field
        let workoutPartStack = createStack(axis: .vertical, spacing: baseSize)
        let stepperStack = createStack(axis: .horizontal, spacing: baseSize * 4)
        stepperStack.alignment = .center
        let workoutPartTitle = createHeaderTitle(title: "Workout Part")
        stepperStack.addArrangedSubview(stepperLabel)
        stepperStack.addArrangedSubview(stepper)
        workoutPartStack.addArrangedSubview(workoutPartTitle)
        workoutPartStack.addArrangedSubview(stepperStack)
        
        addSubview(workoutTypeStack)
        addSubview(datePickerWrapper)
        addSubview(workoutPartStack)
        addSubview(continueBtn)
        
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
        
        continueBtn.leftToSuperview(offset: baseSize * 2)
        continueBtn.rightToSuperview(offset: -1 * baseSize * 3)
        continueBtn.height(50)
        continueBtn.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }

}

extension CreateWorkoutView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dissmissTexfield()
      return true
    }
    
    private func dissmissTexfield(){
        workoutTypeTextfield.endEditing(true)
        workoutTypeTextfield.resignFirstResponder()
    }
}

extension CreateWorkoutView{
    private func createHeaderTitle(title: String)-> UILabel{
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: baseFontSize, weight: .semibold)
        titleLabel.textColor = UIColor.darkGray
        return titleLabel
    }
    
    private func createTexField(placeholder: String)->UITextField{
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.borderStyle = .roundedRect
        return textfield
    }
    
    private func createStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0)-> UIStackView{
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        return stack
    }
}
