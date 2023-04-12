//
//  AnalysisViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//

import UIKit

class AnalysisViewModel: ObservableObject{
    private let calendarHelper = CalendarHelper.shared
    private var doneWorkouts: [DoneWorkout] = []
    var coreDataManager: CoreDataManager?
    var workout: Workout?{
        didSet{configureWorkout()}
    }
    
    func getWorkout()->Workout?{
        return workout
    }
    
    func getDoneWorkouts()->[DoneWorkout]{
        return doneWorkouts
    }
    
    func getCurrentDoneWorkoutPercentage()->CGFloat{
        var percentage = 0.0
        doneWorkouts.forEach { doneWorkout in
            let doneWorkoutDate = doneWorkout.date!
            let doneWorkoutDateString = calendarHelper.getFormattedDateString(doneWorkoutDate)
            let currentDateString = calendarHelper.getFormattedDateString()
            if doneWorkoutDateString == currentDateString {
                percentage = doneWorkout.percentage
            }
        }
        return percentage
    }
    
    func getWeeklyDoneWorkoutsPercentages()->[CGFloat]{
        var percentages: [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        for doneWorkout in doneWorkouts{
            if calendarHelper.compareYear(date1: doneWorkout.date!, date2: Date()),
               calendarHelper.compareMonth(date1: doneWorkout.date!, date2: Date())
            {
                if calendarHelper.compareDay(date1: doneWorkout.date!, date2: Date()){
                    let weekday = calendarHelper.getWeekday(date: doneWorkout.date!)
                    percentages[weekday] = doneWorkout.percentage
                }else{
                    let weekday = calendarHelper.getWeekday(date: doneWorkout.date!)
                    percentages[weekday] = doneWorkout.percentage
                }
            }
        }
        return percentages
    }
    
    func getImages()->[UIImage]{
        var images: [UIImage] = []
        doneWorkouts.forEach { doneWorkout in
            let imageData = doneWorkout.image
            if let imageData, let image = UIImage(data: imageData) {
                images.append(image)
            }
        }
       return images
    }
}

extension AnalysisViewModel{
    func configureWorkout(){
        guard let workout, let doneWorkoutsOrderedSet = workout.doneWorkouts else { return }
        for item in doneWorkoutsOrderedSet{
            guard let doneWorkout = item as? DoneWorkout else { return }
            doneWorkouts.append(doneWorkout)
        }
    }
}
