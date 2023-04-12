//
//  AddWorkoutViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import Combine
import CoreData

class AddWorkoutViewModel{
    @Published var workout: Workout?
    var coreDataManager: CoreDataManager?
    
    func workoutDidCreate(_ name: String, _ duration: Double, _ numberOfParts: Int){
        guard let coreDataManager else { return }
        workout = coreDataManager.createWorkout(name, duration, numberOfParts)
    }
    
    func duplicating(with name: String)-> Bool{
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "%K == %@", #keyPath(Workout.name), name)
        fetchRequest.predicate = predicate
        let workouts = coreDataManager?.fetchWithPredicate(predicate: predicate)
        if workouts != nil && !workouts!.isEmpty{
         return true
        }
        return false
    }
}
