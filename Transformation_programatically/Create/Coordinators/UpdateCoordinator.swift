//
//  UpdateCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/23.
//

import Foundation

protocol UpdateCoordinator: Coordinator{
    func workoutPartDidUpdate(_ workoutPart: WorkoutPart, data: [String:Any])
}
