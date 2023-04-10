//
//  StartWorkoutViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import Combine

class TimerViewController: UIViewController {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private var baseSize:CGFloat {Constants.baseSize}
    private var baseFontSize: CGFloat {Constants.baseFontSize}
    private lazy var minutesLabel: UILabel = configureMinutesLabel()
    private lazy var secondsLabel: UILabel = configureSecondsLabel()
    private lazy var currentWorkoutLabel: UILabel = configureCurrentWorkoutLabel()
    private lazy var nextWorkoutLabel: UILabel = configureNextWorkoutLabel()
    private lazy var startBtn: UIButton = configureStartBtn()
    private lazy var stopBtn: UIButton = configureStopBtn()
    private lazy var takePictureBtn: UIButton = configuretakePictureBtn()
    private lazy var imagePickerController = configureImagePicker()
    
    private var cancellables: [AnyCancellable] = []
    var selectedWorkout: Workout?
    var viewModel: TimerViewModel?

    override func loadView() {
        super.loadView()
        setupViews()
        setupPublishers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Setting Publishers
    func setupPublishers(){
        guard let viewModel else { return }
        viewModel.timerModel.$index.sink {[weak self] value in
            self?.updateTimerView()
        }.store(in: &cancellables)
        
        viewModel.timerModel.$minutes.sink { [weak self] value in
            guard String(value).count > 2 else{
                self?.minutesLabel.text = "0\(value)"
                return
            }
            self?.minutesLabel.text = String(value)
        }.store(in: &cancellables)
        
        viewModel.timerModel.$seconds.sink {[weak self] value in
            guard String(value).count >= 2 else{
                self?.secondsLabel.text = "0\(value)"
                return
            }
            self?.secondsLabel.text = String(value)
        }.store(in: &cancellables)
    }
    
    //MARK: - UI Helper Methods
    
    func updateTimerView(){
        guard let viewModel = viewModel else{return}
        currentWorkoutLabel.text = viewModel.getCurrentWorkout()
        nextWorkoutLabel.text = viewModel.getNextWorkout()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        //labels stack
        let labelsStackWrapper = UIView()
        let colonLabel = components.createLabel(type: .extraLarge, with: ":")
        let labelsStack = components.createStack(axis: .horizontal, spacing: baseSize * 1.5)
        
        labelsStack.addArrangedSubviews([minutesLabel, colonLabel, secondsLabel])
        labelsStackWrapper.addSubview(labelsStack)
        
        //buttons stack
        let buttonsStack = components.createStack(axis: .horizontal, spacing: baseSize * 6)
        buttonsStack.distribution = .fillEqually
        
        //timerStack
        let timerWrapper = UIView()
        timerWrapper.layer.borderWidth = 4
        timerWrapper.layer.borderColor = UIColor.systemBlue.cgColor
        let vrStack = components.createStack(axis: .vertical, spacing: baseSize * 4)
        
        //adding
        buttonsStack.addArrangedSubviews([startBtn, stopBtn])
        vrStack.addArrangedSubviews([currentWorkoutLabel, labelsStackWrapper, nextWorkoutLabel])
        timerWrapper.addSubview(vrStack)
        view.addSubviews([timerWrapper, buttonsStack, takePictureBtn])
        
        //constraints
        timerWrapper.centerInSuperview(offset: CGPoint(x: 0, y: -40))
        timerWrapper.height(250)
        timerWrapper.width(250)
        timerWrapper.layer.cornerRadius = 125
        vrStack.centerInSuperview()
        
        //labels Constraints
        labelsStack.centerInSuperview()
        
        //buttons Constraints
        buttonsStack.centerXToSuperview()
        startBtn.width(60); startBtn.height(60); startBtn.layer.cornerRadius = 30
        stopBtn.width(60); stopBtn.height(60); stopBtn.layer.cornerRadius = 30
        buttonsStack.topToBottom(of: timerWrapper, offset: baseSize*2)
        
        //take photo Button Contraints
        takePictureBtn.leftToSuperview(offset: 20)
        takePictureBtn.rightToSuperview(offset: -20)
        takePictureBtn.bottomToSuperview(offset: -20,usingSafeArea: true)
        takePictureBtn.height(50)
    }
    
    //MARK: - Actions
    @objc private func startTapped(){
        guard let viewModel else {return}
        viewModel.startTimer()
    }
    
    @objc private func stopTapped(){
        guard let viewModel else {return}
        viewModel.stopTimer()
    }

    @objc private func takePhotoTapped(){
        present(imagePickerController, animated: true)
    }
    
}


//MARK: - Configure UI Elements
extension TimerViewController{
    private func configureMinutesLabel()->UILabel{
        return components.createLabel(type: .extraLarge,with: "")
    }
    private func configureSecondsLabel()->UILabel{
        return components.createLabel(type: .extraLarge, with: "")
    }
    private func configureCurrentWorkoutLabel()->UILabel{
        return components.createLabel(type: .medium, with: "Current Workout", centered: true)
    }
    private func configureNextWorkoutLabel()->UILabel{
        let label = components.createLabel(type: .medium, with: "Next Workout", centered: true)
        label.textColor = .lightGray
        return label
    }
    private func configureStartBtn()->UIButton{
        let button = components.createCicularButton(image: .startButtonImageFilled)
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }
    
    private func configureStopBtn()->UIButton{
        let button = components.createCicularButton(image: .stopButtonImageFilled)
        button.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
        return button
    }
    
    private func configuretakePictureBtn()->UIButton{
        let button = components.createButton(text: "Take Photo")
        button.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
        return button
    }
    
    private func configureImagePicker()->UIImagePickerController{
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        return imagePickerController
    }
    
}

//MARK: - UIImagePickerController Delegate
extension TimerViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        //do something
    }
}
