//
//  AnalysisViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//

import UIKit

class AnalysisViewModel: ObservableObject{
    private let workout: Workout
    private var doneWorkouts: [DoneWorkouts] = []
    var coredataHelper: CoreDataHelper?
    
    init(_ workout: Workout) {
        self.workout = workout
        print(workout.doneWorkouts)
    }
    
    func getWorkout()->Workout{
        return workout
    }
    
    func getDoneWorkouts()->[DoneWorkouts]{
        return doneWorkouts
    }
    
}
