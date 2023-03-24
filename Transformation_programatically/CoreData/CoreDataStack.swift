//
//  CoreDataStack.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/20.
//

import Foundation
import CoreData

class CoreDataStack{
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    lazy var managedContext: NSManagedObjectContext = {
        storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError?{
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext(){
        guard managedContext.hasChanges else{print("No changes happened"); return}
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save changes \(error.localizedDescription)")
        }
    }
}
