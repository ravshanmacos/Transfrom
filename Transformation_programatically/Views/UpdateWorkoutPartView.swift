//
//  CreateWorkoutPartView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/04.
//

import UIKit
import Combine
import TinyConstraints

class UpdateWorkoutPartView: UIView {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private var baseFontSize: CGFloat {
        return Constants.baseFontSize
    }
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    
    private lazy var workoutPartTextfield = {
        return components.createTexField(placeholder: "Example: Morning Workout")
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()
    
    private lazy var doneBtn: UIButton = {
        let btn = components.createButton(text: "Done")
        btn.addTarget(self, action: #selector(doneBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    @Published private var stepperCount: Int = 0
    private var cancellables: [AnyCancellable] = []
    var delegate: EditWorkoutPartControllerDelegate?
    
    
    //MARK: - LifeCycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupDelegates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this view should not be implemented from storyboard")
    }
    
    convenience init(model: WorkoutPart) {
        self.init(frame: CGRect.zero)
        configure(model)
        setupDelegates()
    }
    
    @objc private func doneBtnTapped(){
        guard let workoutPartName = workoutPartTextfield.text else{return}
        let duration = datePicker.countDownDuration / 60
        let data:[String: Any] = ["name": workoutPartName, "duration": duration]
        delegate?.editWorkoutPartControllerSaveTapped(data: data)
    }
    
    private func setupDelegates(){
        workoutPartTextfield.delegate = self
    }
    
    private func setupViews(){
        //setup input field
        let workoutTypeTitle = components.createHeaderTitle(title: "Workout Type")
        let workoutTypeStack = components.createStack(axis: .vertical, spacing: baseSize,
                                                      views: [workoutTypeTitle, workoutPartTextfield])
        workoutTypeStack.distribution = .fillProportionally
        
        //setup date picker
        let datePickerTitle = components.createHeaderTitle(title: "Workout Duration")
        let datePickerWrapper = components.createStack(axis: .vertical, views: [datePickerTitle, datePicker])
        
        let buttonsStack = components.createStack()
        buttonsStack.addArrangedSubview(doneBtn)
        
        [workoutTypeStack, datePickerWrapper, buttonsStack].forEach{addSubview($0)}
        
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

}

extension UpdateWorkoutPartView{
    private func configure(_ model: WorkoutPart){
        workoutPartTextfield.text = model.name
        datePicker.countDownDuration = model.duration * 60
    }
}

extension UpdateWorkoutPartView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dissmissTexfield()
      return true
    }
    
    private func dissmissTexfield(){
        workoutPartTextfield.endEditing(true)
        workoutPartTextfield.resignFirstResponder()
    }
}

