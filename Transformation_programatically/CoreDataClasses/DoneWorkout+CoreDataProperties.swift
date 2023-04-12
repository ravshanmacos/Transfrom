//
//  DoneWorkout+CoreDataProperties.swift
//  
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//
//

import Foundation
import CoreData


extension DoneWorkout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoneWorkout> {
        return NSFetchRequest<DoneWorkout>(entityName: "DoneWorkout")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var percentage: Double
    @NSManaged public var workout: Workout?

}
