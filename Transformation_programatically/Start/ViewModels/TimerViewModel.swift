//
//  TimerViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import Foundation
import Combine

class TimerViewModel{
    
    //MARK: - Properties
    private let coreDataStack = CoreDataStack(modelName: "Transformation")
    private var index = 0{didSet{updateTimer()}}
    private var cancellables: [AnyCancellable] = []
    private var workoutParts: [WorkoutPart]
    private lazy var currentWorkout: WorkoutPart = {
        return workoutParts[index]
    }()
    private lazy var nextWorkout: WorkoutPart = {
        return workoutParts[index + 1]
    }()
    lazy var timerModel: TimerModel = {
        let workoutPart = workoutParts[index]
        let duration = configureDuration(duration: Int(workoutPart.duration))
        let timerModel =
        TimerModel(minutes: duration.minutes, seconds: duration.seconds, length: workoutParts.count)
        return timerModel
    }()
    
    var coredataHelper: CoreDataHelper?
    
    //MARK: - LifeCycle
    
    init(workoutParts: [WorkoutPart]) {
        self.workoutParts = workoutParts
        setupPublishers()
    }
    
    private func setupPublishers(){
        timerModel.$index.sink {[weak self] value in
            self?.index = value
        }.store(in: &cancellables)
    }
    
    //MARK: - Methods
    func getMinutesString()->String{
        guard timerModel.minutes > 0 else{
            return "00"
        }
        guard String(timerModel.minutes).count > 2 else{
            return "0\(timerModel.minutes)"
        }
        return String(timerModel.minutes)
    }
    
    func getSecondsString()->String{
        guard timerModel.seconds > 0 else{
            return "00"
        }
        return String(timerModel.seconds)
    }
    
    func getCurrentWorkout()->String{
        return currentWorkout.name!
    }
    
    func getNextWorkout()->String{
        return nextWorkout.name!
    }
    
    func startTimer(){
        timerModel.startTimer()
    }
    func stopTimer(){
        timerModel.stopTimer()
    }
}

extension TimerViewModel{
    
    //called when index changed
    private func updateTimer(){
        guard index < workoutParts.count else{
            timerModel.timer.invalidate();
            return
        }
        currentWorkout = workoutParts[index]
        if index + 1 > workoutParts.count-1{
            guard let coredataHelper else{return}
            nextWorkout = coredataHelper.createWorkoutPart("End", 0)
        } else{
            nextWorkout = workoutParts[index+1]
        }
        let duration = configureDuration(duration: Int(currentWorkout.duration))
        timerModel.updateWorkout(minutes: duration.minutes, seconds: duration.seconds)
    }
    
    private func configureDuration(duration: Int)-> (minutes: Int, seconds: Int){
        if duration % 60 == 0{
            return (minutes: duration / 60, seconds: 0)
        }else{
            return (minutes: duration / 60, seconds: 60 * (duration % 60))
        }
    }
}
