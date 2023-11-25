//
//  PersistenceController.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 17/11/23.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "Model")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/nul")
        }
        
        container.loadPersistentStores { desciription, error in
            if let error = error as NSError? {
                fatalError("Error loading container \(error), \(error.userInfo)")
            }
        }
    }
}
