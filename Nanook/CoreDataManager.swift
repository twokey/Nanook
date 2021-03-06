//
//  CoreDataManager.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-14.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    
    // MARK: Properties
    
    private let modelName: String
    static let sharedInstance = CoreDataManager(modelName: "Nanook")
    
    
    // MARK: - Core Data Stack

    private lazy var managedObjectModel: NSManagedObjectModel? = {
        
        // Fetch model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        guard let managedObjectModel = self.managedObjectModel else {
            return nil
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to reach the documents folder")
        }
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        print(persistentStoreURL)
        let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)
        } catch {
            let addPersistentStoreError = error as NSError
            
            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }

        return persistentStoreCoordinator
    }()

    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    public private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.parent = self.privateManagedObjectContext
        
        return managedObjectContext
    }()
    
    
    // MARK: Initializers
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    public func privateChildManagedObjectContext() -> NSManagedObjectContext {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.parent = mainManagedObjectContext
        
        return managedObjectContext
    }
    
    // MARK: - Helper Methods
    
    public func saveChanges() {
        mainManagedObjectContext.performAndWait({
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Main Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        })
        
        privateManagedObjectContext.perform({
            do {
                if self.privateManagedObjectContext.hasChanges {
                    try self.privateManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Private Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        })
    }
    
    func dropAllData() {

        if let entitesByName = persistentStoreCoordinator?.managedObjectModel.entities {
            
            for entityDescription in entitesByName {
                deleteAllObjectsFor(entityDescription)
            }
        }
    }
    
    func deleteAllObjectsFor(_ entityDescription: NSEntityDescription) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityDescription.name!)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
        try mainManagedObjectContext.execute(request)
        } catch {
            print("Cannot clean entity: \(entityDescription)")
        }
    }

}
