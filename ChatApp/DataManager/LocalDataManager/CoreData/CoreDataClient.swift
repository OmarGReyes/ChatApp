//
//  CoreDataClient.swift
//  PostFeed
//
//  Created by Andres Rojas on 26/02/22.
//

import Foundation
import Combine
import CoreData

enum Failure: Error {
    case cacheError
    case notFound
}

final class CoreDataClient {
    
    let context: NSManagedObjectContext

    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    func getAll<T: NSManagedObject>(entity: T.Type,
                                    predicate: NSPredicate? = nil,
                                    sortDescriptor: [NSSortDescriptor]? = nil) async throws -> [T] {
        
        try await context.perform({
            do {
                guard let request: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
                    throw Failure.cacheError
                }
                request.predicate = predicate
                request.sortDescriptors = sortDescriptor
                let values = try self.context.fetch(request)

                return values
            } catch {
                throw error
            }

        })
    }

    func delete<T: NSManagedObject>(entity: T.Type,
        
                                    predicate: NSPredicate) async throws {
        
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = context
        
        try await privateMOC.perform({
            do {
                guard let request: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
                    throw Failure.cacheError
                }
                request.predicate = predicate
                let objects = try privateMOC.fetch(request)

                objects.forEach { object in
                    privateMOC.delete(object)
                }

                try privateMOC.save()
                try self.context.performAndWait {
                    do {
                        try self.context.save()
                    } catch {
                        throw URLError(.cannotRemoveFile)
                    }
                }
            } catch {
                throw Failure.cacheError
            }

        })
    }

    func add<T: NSManagedObject>(entity: T.Type,  _ body: @escaping (inout T) -> Void) async throws -> T {
        try await context.perform({
            var object = T(context: self.context)
            body(&object)
            do {
                try self.context.save()
                return object
            } catch {
                throw error
            }
        })
    }

    func update<T: NSManagedObject>(entity: T.Type,
                                    predicate: NSPredicate,
                                    _ body: @escaping(inout T) -> Void) async throws -> T {
        
        
        return try await context.perform {
            do {
                guard let request: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
                    throw Failure.cacheError
                }
                request.predicate = predicate
                var object = try self.context.fetch(request).first
                if object != nil {
                    body(&object!)
                    try self.context.save()
                    return object!
                } else {

                    throw Failure.notFound
                }

            } catch {
                throw error
            }
        }
    }

    func get<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate) async throws -> T? {
        
        try await context.perform({
            do {
                guard let request: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
                    throw Failure.cacheError
                }
                request.predicate = predicate
                let  object = try self.context.fetch(request).first
                return object
            } catch {
                throw error
            }

        })
    }
}
