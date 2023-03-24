//
//  WorkoutPart+CoreDataProperties.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/22.
//
//

import Foundation
import CoreData


extension WorkoutPart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutPart> {
        return NSFetchRequest<WorkoutPart>(entityName: "WorkoutPart")
    }

    @NSManaged public var duration: Double
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var workout: Workout?

}

extension WorkoutPart : Identifiable {

}
