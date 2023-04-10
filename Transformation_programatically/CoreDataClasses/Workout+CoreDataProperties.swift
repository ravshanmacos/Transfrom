//
//  Workout+CoreDataProperties.swift
//  
//
//  Created by Ravshanbek Tursunbaev on 2023/04/10.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var date: Date?
    @NSManaged public var duration: Double
    @NSManaged public var name: String?
    @NSManaged public var workoutParts: NSOrderedSet?
    @NSManaged public var doneWorkouts: NSOrderedSet?

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

// MARK: Generated accessors for doneWorkouts
extension Workout {

    @objc(insertObject:inDoneWorkoutsAtIndex:)
    @NSManaged public func insertIntoDoneWorkouts(_ value: DoneWorkouts, at idx: Int)

    @objc(removeObjectFromDoneWorkoutsAtIndex:)
    @NSManaged public func removeFromDoneWorkouts(at idx: Int)

    @objc(insertDoneWorkouts:atIndexes:)
    @NSManaged public func insertIntoDoneWorkouts(_ values: [DoneWorkouts], at indexes: NSIndexSet)

    @objc(removeDoneWorkoutsAtIndexes:)
    @NSManaged public func removeFromDoneWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInDoneWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceDoneWorkouts(at idx: Int, with value: DoneWorkouts)

    @objc(replaceDoneWorkoutsAtIndexes:withDoneWorkouts:)
    @NSManaged public func replaceDoneWorkouts(at indexes: NSIndexSet, with values: [DoneWorkouts])

    @objc(addDoneWorkoutsObject:)
    @NSManaged public func addToDoneWorkouts(_ value: DoneWorkouts)

    @objc(removeDoneWorkoutsObject:)
    @NSManaged public func removeFromDoneWorkouts(_ value: DoneWorkouts)

    @objc(addDoneWorkouts:)
    @NSManaged public func addToDoneWorkouts(_ values: NSOrderedSet)

    @objc(removeDoneWorkouts:)
    @NSManaged public func removeFromDoneWorkouts(_ values: NSOrderedSet)

}
