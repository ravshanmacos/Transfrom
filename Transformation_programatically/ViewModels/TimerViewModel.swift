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
    
    private var index = 0{didSet{updateTimer()}}
    private var cancellables: [AnyCancellable] = []
    private var workouts: [Workout]
    private lazy var currentWorkout: Workout = {
        return workouts[0]
    }()
    private lazy var nextWorkout: Workout = {
        return workouts[0]
    }()
    lazy var timerModel: TimerModel = {
        let duration = configureDuration(duration: 120)
        let timerModel =
        TimerModel(minutes: duration.minutes, seconds: duration.seconds, length: workouts.count)
        return timerModel
    }()
    
    //MARK: - LifeCycle
    
    init(workouts: [Workout]) {
        self.workouts = workouts
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
        return "hello"
    }
    
    func getNextWorkout()->String{
        return "hello2"
    }
    
    func startTimer(){
        timerModel.startTimer()
    }
    func stopTimer(){
        timerModel.stopTimer()
    }
}

extension TimerViewModel{
    private func configureDuration(duration: Int)-> (minutes: Int, seconds: Int){
        if duration % 60 == 0{
            return (minutes: duration / 60, seconds: 0)
        }else{
            return (minutes: duration / 60, seconds: 60 * (duration % 60))
        }
    }
    
    private func updateTimer(){
        guard index < workouts.count else{
            timerModel.timer.invalidate();
            return
        }
        currentWorkout = workouts[index]
        if index + 1 > workouts.count-1{
            //nextWorkout = Workout(name: "End ", duration: 0)
        } else{
           // nextWorkout = workouts[index+1]
        }
        let duration = configureDuration(duration: 120)
        timerModel.updateWorkout(minutes: duration.minutes, seconds: duration.seconds)
    }
}
