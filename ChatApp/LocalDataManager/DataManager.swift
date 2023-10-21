//
//  DataManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/10/23.
//

import CoreData
import Foundation

class DataManager: NSObject, ObservableObject {
    @Published var messages: [Message] = []
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
