//
//  CoreDataService.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import CoreData
import Foundation

class CoreDataService<T: Codable>: DataPersistence {
    private let persistentContainerName: String

    init(containerName: String) {
        persistentContainerName = containerName
    }
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { _, error in
            guard let error = error as NSError? else { return }
            NSLog("Failed to load persistent stores: \(error), \(error.userInfo)")
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    func load() throws -> T? {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            // FIXME: Add decode functionality from Codable
            return try JSONDecoder().decode(T.self, from: Data())
        } catch {
            throw CoreDataError.loadFailed(error)
        }
    }
    
    func save(_ item: T) throws {
        guard viewContext.hasChanges else { return }
        
        do {
            // FIXME: Add encode functionality from Codable
            try viewContext.save()
        } catch {
            throw CoreDataError.saveFailed(error)
        }
    }
}
