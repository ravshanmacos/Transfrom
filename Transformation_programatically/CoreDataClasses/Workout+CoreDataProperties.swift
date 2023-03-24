//
//  Workout+CoreDataProperties.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/22.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var done: Bool
    @NSManaged public var duration: Double
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var workoutParts: NSOrderedSet?

}

// MARK: Generated accessors for workoutParts
extension Workout {

    @objc(insertObject:inWorkoutPartsAtIndex:)
    @NSManaged public func insertIntoWorkoutParts(_ value: WorkoutPart, at idx: Int)

    @objc(removeObjectFromWorkoutPartsAtIndex:)
    @NSManaged public func removeFromWorkoutParts(at idx: Int)

    @objc(insertWorkoutParts:atIndexes:)
    @NSManaged public func insertIntoWorkoutParts(_ values: [WorkoutPart], at indexes: NSIndexSet)

    @objc(removeWorkoutPartsAtIndexes:)
    @NSManaged public func removeFromWorkoutParts(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutPartsAtIndex:withObject:)
    @NSManaged public func replaceWorkoutParts(at idx: Int, with value: WorkoutPart)

    @objc(replaceWorkoutPartsAtIndexes:withWorkoutParts:)
    @NSManaged public func replaceWorkoutParts(at indexes: NSIndexSet, with values: [WorkoutPart])

    @objc(addWorkoutPartsObject:)
    @NSManaged public func addToWorkoutParts(_ value: WorkoutPart)

    @objc(removeWorkoutPartsObject:)
    @NSManaged public func removeFromWorkoutParts(_ value: WorkoutPart)

    @objc(addWorkoutParts:)
    @NSManaged public func addToWorkoutParts(_ values: NSOrderedSet)

    @objc(removeWorkoutParts:)
    @NSManaged public func removeFromWorkoutParts(_ values: NSOrderedSet)

}

extension Workout : Identifiable {

}
