//
//  TimerView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import Combine
import TinyConstraints

class TimerView: UIView {
    
    //MARK: - Properties
    private let components = UIComponents.shared
    private var baseSize:CGFloat {Constants.baseSize}
    private var baseFontSize: CGFloat {Constants.baseFontSize}
    private var cancellables: [AnyCancellable] = []
    private var model: TimerViewModel?
    
    private lazy var minutesLabel: UILabel = {
        return components.createLabel(type: .extraLarge,with: "")
    }()
    
    private lazy var secondsLabel: UILabel = {
        return components.createLabel(type: .extraLarge, with: "")
    }()
    
    private lazy var currentWorkoutLabel: UILabel = {
        let label = components.createLabel(type: .medium, with: "Current Workout", centered: true)
        return label
    }()
    
    private lazy var nextWorkoutLabel: UILabel = {
        let label = components.createLabel(type: .medium, with: "Next Workout", centered: true)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var startBtn: UIButton = {
        let image = UIImage.init(systemName: "play.fill")!
        let button = components.createCicularButton(image: image)
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopBtn: UIButton = {
       let image = UIImage.init(systemName: "stop.fill")!
        let button = components.createCicularButton(image: image)
       button.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
       return button
    }()

    //MARK: - Ovveride Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewStyle()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("this should be implemented storyboard")
    }
    
    convenience init(model: TimerViewModel) {
        self.init(frame: CGRect.zero)
        self.model = model
        setupPublishers()
        configureView(with: model)
    }

    func setupPublishers(){
        model!.timerModel.$index.sink {[weak self] value in
            if value != 0{
                self?.updateTimerView()
            }
        }.store(in: &cancellables)
        
        model!.timerModel.$minutes.sink { [weak self] value in
            guard String(value).count > 2 else{
                self?.minutesLabel.text = "0\(value)"
                return
            }
            self?.minutesLabel.text = String(value)
        }.store(in: &cancellables)
        
        model!.timerModel.$seconds.sink {[weak self] value in
            
            guard String(value).count >= 2 else{
                self?.secondsLabel.text = "0\(value)"
                return
            }
            
            self?.secondsLabel.text = String(value)
        }.store(in: &cancellables)
    }
    
    func updateTimerView(){
        guard let model = model else{return}
        minutesLabel.text = model.getMinutesString()
        secondsLabel.text = model.getSecondsString()
        currentWorkoutLabel.text = model.getCurrentWorkout()
        nextWorkoutLabel.text = model.getNextWorkout()
    }
    
    @objc private func startTapped(){
        model?.startTimer()
    }
    
    @objc private func stopTapped(){
        model?.stopTimer()
    }
    
    //MARK: - Custom Methods
    
    private func setupViewStyle(){
        backgroundColor = .white
    }
    
    private func setupViews(){
        
        //labels stack
        let labelsStackWrapper = UIView()
        let colonLabel = components.createLabel(type: .extraLarge, with: ":")
        let labelsStack = components.createStack(axis: .horizontal, spacing: baseSize * 1.5,
                                                 views: [minutesLabel, colonLabel, secondsLabel])
        labelsStackWrapper.addSubview(labelsStack)
        
        //buttons stack
        let buttonsStack = components.createStack(axis: .horizontal, spacing: baseSize * 6, views: [startBtn, stopBtn])
        buttonsStack.distribution = .fillEqually
        
        //timerStack
        let timerWrapper = UIView()
        timerWrapper.layer.borderWidth = 4
        timerWrapper.layer.borderColor = UIColor.systemBlue.cgColor
        
        let vrStack = components.createStack(axis: .vertical, spacing: baseSize * 4,
                                             views: [currentWorkoutLabel, labelsStackWrapper, nextWorkoutLabel])
        
        timerWrapper.addSubview(vrStack)
        [timerWrapper,buttonsStack].forEach{addSubview($0)}
        
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
        
    }
}
//MARK: - Configuration

extension TimerView{
    private func configureView(with model: TimerViewModel){
        minutesLabel.text = model.getMinutesString()
        secondsLabel.text = model.getSecondsString()
        currentWorkoutLabel.text = model.getCurrentWorkout()
        nextWorkoutLabel.text = model.getNextWorkout()
    }
}
