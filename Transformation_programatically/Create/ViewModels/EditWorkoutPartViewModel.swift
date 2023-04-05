//
//  EditWorkoutViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import Combine

class EditWorkoutPartViewModel: ObservableObject{
    
    let workoutPart: WorkoutPart
    @Published var isDataUpdated: [String: Any] = [:]
    
    init(workoutPart: WorkoutPart) {
        self.workoutPart = workoutPart
    }
    
    func saveTapped(_ data: [String:Any]){
        isDataUpdated = data
    }
    
    func getWorkoutPartName()->String{
        return workoutPart.name ?? ""
    }
    
    func getWorkoutPartDuration()->Double{
        return workoutPart.duration
    }
}


