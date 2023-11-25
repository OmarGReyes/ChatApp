//
//  CDMessage+Helper.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/11/23.
//

import CoreData
import Foundation

extension CDMessage {
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDMessage> {
        let request = CDMessage.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        request.predicate = predicate
        return request
    }
}
