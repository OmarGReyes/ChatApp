//
//  NSPredicate+Helper.swift
//  ChatApp
//
//  Created by Omar Gonzalez on 22/11/23.
//

import CoreData

extension NSPredicate {
    static let all = NSPredicate(format: "TRUEPREDICATE")
    static let none = NSPredicate(format: "FALSEPREDICATE")
    
    enum usersPredicates {
        case findById(String)
        
        var predicate: NSPredicate {
            switch self {
            case .findById(let id):
                return NSPredicate(format: "id == %@", id)
            }
        }
    }
    
    enum MessagePredicates {
        case findMessageByUserId(String)
        
        var predicate: NSPredicate {
            switch self {
            case .findMessageByUserId(let id):
                return NSPredicate(format: "userId == %@", id)
            }
        }
    }
}
