//
//  AnalysisViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//

import UIKit

class AnalysisViewModel: ObservableObject{
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
