//
//  TimerViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import UIKit
import Combine

class TimerViewModel{
    
    //MARK: - Properties
    private let calendarHelper = CalendarHelper.shared
    private var index = 0{didSet{updateTimer()}}
    private var cancellables: [AnyCancellable] = []
    private var workoutParts: [WorkoutPart] = []
    private lazy var currentWorkoutPart: WorkoutPart = configureCurrentWorkout()
    private lazy var nextWorkoutPart: WorkoutPart = configureNextWorkout()
    lazy var timerModel: TimerModel = configureTimer()
    
    @Published var selectedImage: UIImage?
    @Published var isUpdatingDidFinish: Bool = false
    var coreDataManager: CoreDataManager?
    var workout: Workout?{
        didSet{
            self.configureWorkout()
            setupPublishers()
        }
    }
    
    //MARK: - LifeCycle
    
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
        return currentWorkoutPart.name!
    }
    
    func getNextWorkout()->String{
        return nextWorkoutPart.name!
    }
    
    func startTimer(){
        timerModel.startTimer()
    }
    func stopTimer(){
        timerModel.stopTimer()
    }
    
    func updateWorkout(){
        guard let coreDataManager, let workout ,let selectedImage else {return}
        let currentDateString = calendarHelper.getFormattedDateString()
        guard let doneWorkouts = workout.doneWorkouts, let imageData = selectedImage.pngData() else {return}
        if doneWorkouts.set.isEmpty{
            let doneWorkout = coreDataManager.createDoneWorkout(Date(),imageData, 0.5)
            workout.addToDoneWorkouts(doneWorkout)
            coreDataManager.coreDataStack.saveContext()
        }else{
            doneWorkouts.forEach { element in
                let doneWorkout = element as! DoneWorkout
                let date = doneWorkout.date!
                let doneWorkoutString = calendarHelper.getFormattedDateString(date)
                if currentDateString != doneWorkoutString{
                    let doneWorkout = coreDataManager.createDoneWorkout(Date(),imageData, 0.5)
                    workout.addToDoneWorkouts(doneWorkout)
                    coreDataManager.coreDataStack.saveContext()
                }else{
                    let data: [String: Any] = [
                        "image": imageData,
                        "percentage": 0.5
                    ]
                    coreDataManager.update(doneWorkout, data: data)
                }
            }
        }
        isUpdatingDidFinish = true
    }
}

extension TimerViewModel{
    
    //called when index changed
    private func updateTimer(){
        guard index < workoutParts.count else{
            timerModel.timer.invalidate();
            return
        }
        currentWorkoutPart = workoutParts[index]
        if index + 1 > workoutParts.count-1{
            guard let coreDataManager else{return}
            nextWorkoutPart = coreDataManager.createWorkoutPart("End", 0)
        } else{
            nextWorkoutPart = workoutParts[index+1]
        }
        let duration = configureDuration(duration: Int(currentWorkoutPart.duration))
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

extension TimerViewModel{
    private func configureWorkout(){
        guard let workout, let workoutPartsSet = workout.workoutParts else { return }
        workoutPartsSet.forEach({ el in
            let workoutPart = el as! WorkoutPart
            workoutParts.append(workoutPart)
        })
    }
    
    private func configureCurrentWorkout()->WorkoutPart{
        return workoutParts[index]
    }
    
    private func configureNextWorkout()->WorkoutPart{
        return workoutParts[index + 1]
    }
    
    private func configureTimer()->TimerModel{
        let workoutPart = workoutParts[index]
        let duration = configureDuration(duration: Int(workoutPart.duration))
        let timerModel =
        TimerModel(minutes: duration.minutes, seconds: duration.seconds, length: workoutParts.count)
        return timerModel
    }
}
