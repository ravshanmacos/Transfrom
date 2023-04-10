//
//  WorkoutPart+CoreDataProperties.swift
//  
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//
//

import Foundation
import CoreData


extension WorkoutPart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutPart> {
        return NSFetchRequest<WorkoutPart>(entityName: "WorkoutPart")
    }

    @NSManaged public var date: Date?
    @NSManaged public var duration: Double
    @NSManaged public var name: String?
    @NSManaged public var workout: Workout?

}
