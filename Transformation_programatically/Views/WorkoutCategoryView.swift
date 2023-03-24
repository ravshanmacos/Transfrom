//
//  workoutCategoryView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints

class WorkoutCategoryView: UIView {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private var baseSize:CGFloat {
        return Constants.baseSize
    }
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var startWorkoutButton: UIButton = {
        let button = components.createButton(text: "Start Workout")
        print(data.isEmpty)
        if data.isEmpty{
            button.isEnabled = false
            button.backgroundColor = UIColor.white
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.setTitleColor(UIColor.lightGray, for: .normal)
        }
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    private var data:[String] = []
    private var selectedWorkout: String?
    var delegate: WorkoutCategoryDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this should be implemented storyboard")
    }
    
    convenience init(data: [String]) {
        self.init(frame: CGRect.zero)
        if !data.isEmpty{self.data = data}
        setupDelegates()
        setupViews()
        setupConstraints()
    }
    
    @objc private func startTapped(){
        if let selectedWorkout{
            delegate?.workoutDidSelect(selectedWorkout)
            return
        }
        delegate?.workoutDidSelect(data[0])
    }
    
    private func setupDelegates(){
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setupViews(){
        backgroundColor = .white
        let buttonsStack = components.createStack()
        buttonsStack.addArrangedSubview(startWorkoutButton)
        
        [pickerView, buttonsStack].forEach{addSubview($0)}
        
        pickerView.centerInSuperview()
        
        buttonsStack.leftToSuperview(offset: 20)
        buttonsStack.rightToSuperview(offset: -20)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }
    private func setupConstraints(){}
}

//MARK: - PickerView Datasource and Delegate methods

extension WorkoutCategoryView: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard data.isEmpty else{
            return data.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard data.isEmpty else{
            return data[row]
        }
        return "Oops! Empty"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard data.isEmpty else{
            selectedWorkout = data[row]
            return
        }
       return
    }
    
}


