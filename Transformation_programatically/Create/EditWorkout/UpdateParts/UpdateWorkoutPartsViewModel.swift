//
//  UpdateWorkoutPartsViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import Combine

class UpdateWorkoutPartsViewModel: ObservableObject{
    private var workoutParts: [WorkoutPart] = []
    var coreDataHelper: CoreDataHelper?
    var workout: Workout?{didSet{configureWorkoutParts()}}
    @Published var selectedWorkoutPart: WorkoutPart? = nil
    @Published var isWorkoutUpdateDidFinish: Bool = false
    
    //MARK: - Workout Methods
    func getWorkoutName()->String{
        guard let workout, let name = workout.name else { return ""}
        return name
    }
    func getWorkoutDuration()->Double{
        guard let workout else { return 0}
        return workout.duration / 60
    }
    
    func getActualWorkoutDuration()->Double{
        guard let workout else { return 0}
        return workout.duration
    }
    
    //MARK: - Workout Part Methods
    func getWorkoutParts()->[WorkoutPart]{
        return workoutParts
    }
    
    func getWorkoutPartsCount()->Int{
        return workoutParts.isEmpty ? 1 : workoutParts.count
    }
    
    func getWorkoutPart(at indexPath: IndexPath)->WorkoutPart{
        return workoutParts[indexPath.row]
    }
    
    func getWorkoutPartsTotalDuration()->Double{
        return workoutParts.map({$0.duration}).reduce(0, +)
    }
    
    func setSelectedWorkoutPart(by indexPath: IndexPath){
        self.selectedWorkoutPart = workoutParts[indexPath.row]
    }
    
    func updateWorkoutParts(_ workoutPart: WorkoutPart, data: [String: Any]){
        let index = workoutParts.firstIndex(of: workoutPart)!
        workoutParts[index].name = (data["name"] as! String)
        workoutParts[index].duration = data["duration"] as! Double
    }
    
    func updatingDidFinish()->String?{
        guard isDurationsEqual() else {return "Overall duration did not match"}
        let orederedSet = NSOrderedSet(array: workoutParts)
        let data: [String: Any] = [
            "duration": getWorkoutPartsTotalDuration(),
            "workoutParts": orederedSet
        ]
        guard let coreDataHelper, let workout else { return "coredataHelper or workout is nil"}
        coreDataHelper.update(workout, data: data)
        isWorkoutUpdateDidFinish = true
        return nil
    }
    
}


//MARK: - Helpers
extension UpdateWorkoutPartsViewModel{
    private func configureWorkoutParts(){
        guard let workout, let workoutPartsSet = workout.workoutParts else { return }
        for workoutPart in workoutPartsSet{
            let part = workoutPart as! WorkoutPart
            workoutParts.append(part)
        }
    }
    
    private func isDurationsEqual()-> Bool{
        if getActualWorkoutDuration() != getWorkoutPartsTotalDuration(){
            return false
        }
        return true
    }
}

//MARK: - For Coordinator
extension UpdateWorkoutPartsViewModel{
    
}
