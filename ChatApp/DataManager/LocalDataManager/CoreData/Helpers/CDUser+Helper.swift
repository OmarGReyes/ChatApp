//
//  CDUser+Helper.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 19/11/23.
//

import CoreData
import Foundation

extension CDUser {
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDUser> {
        let request = CDUser.fetchRequest()
        request.predicate = predicate
        return request
    }
}
