//
//  DoneWorkouts+CoreDataProperties.swift
//  
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//
//

import Foundation
import CoreData


extension DoneWorkouts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoneWorkouts> {
        return NSFetchRequest<DoneWorkouts>(entityName: "DoneWorkouts")
    }

    @NSManaged public var images: Data?
    @NSManaged public var date: Date?
    @NSManaged public var percentage: Double
    @NSManaged public var workout: Workout?

}
