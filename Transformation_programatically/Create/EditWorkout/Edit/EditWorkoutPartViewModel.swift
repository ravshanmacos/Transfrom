//
//  EditWorkoutViewModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit
import Combine

class EditWorkoutPartViewModel: ObservableObject{
    
    var workoutPart: WorkoutPart?
    @Published var isDataUpdated: [String: Any] = [:]
    
    func saveTapped(_ data: [String:Any]){
        isDataUpdated = data
    }
    
    func getWorkoutPartName()->String{
        guard let workoutPart, let name = workoutPart.name else { return ""}
        return name
    }
    
    func getWorkoutPartDuration()->Double{
        guard let workoutPart else { return 0}
        return workoutPart.duration
    }
}


