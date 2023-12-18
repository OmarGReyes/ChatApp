//
//  CoreDataLocalManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 18/12/23.
//

import Foundation

struct CoreDataLocalManager {
    let coreDataClient: CoreDataClient
    
    init(coreDataClient: CoreDataClient) {
        self.coreDataClient = coreDataClient
    }
}
