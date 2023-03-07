//
//  Workout.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import Foundation
import Combine

class WorkoutModel {
    let type:String
    let duration:Double
    var workoutParts:[WorkoutPart] = []
    @Published var numberOfParts: Int = 0
    private var cancellables: [AnyCancellable] = []
    
    init(type: String, duration: Double, parts: Int) {
        self.type = type
        self.duration = duration
        self.numberOfParts = parts
        setObservers()
    }
    
    private func setObservers(){
        $numberOfParts.sink { value in
            for index in 0..<value{
                let formattedDuration =  self.formatDurationInMinutes()
                self.workoutParts.append(WorkoutPart(name: "Edit Part - \(index)", duration: formattedDuration))
            }
        }.store(in: &cancellables)
    }
    
    private func formatDurationInMinutes()-> Double{
        let seconds = duration/Double(numberOfParts)
        let minutes = seconds / 60
        return minutes
    }
    
}

struct Workout{
    let name: String
    let duration: Int
}

struct WorkoutPart{
    let name: String
    let duration: Double
}
