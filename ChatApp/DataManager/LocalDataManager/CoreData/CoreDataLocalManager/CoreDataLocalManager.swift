//
//  CoreDataLocalManager.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 22/11/23.
//

import Combine
import Foundation

final class CoreDataLocalManager {
    let coreDataClient: CoreDataClient
    
    init(coreDataClient: CoreDataClient) {
        self.coreDataClient = coreDataClient
    }
}
