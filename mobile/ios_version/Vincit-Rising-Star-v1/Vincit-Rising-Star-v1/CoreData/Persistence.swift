//
//  Persistence.swift
//  Vincit-Rising-Star-v1
//
//  Created by Oskari Saarinen on 29.12.2021.
//

import CoreData

struct PersistenceController {
    /// a Singleton for the entire app to use
    static let shared = PersistenceController()
    
    /// Storage for CoreData
    let container: NSPersistentCloudKitContainer
    
    /// For SwiftUI previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for n in 0..<10 {
            let newCoin = Coin(context: viewContext)
            newCoin.id = UUID().uuidString
            newCoin.symbol = "C\(n)"
            newCoin.name = "Coin-\(n)"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    /// Save changes in CoreData
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Error saving in CoreData: \(nsError), \(nsError.userInfo)")
            }
        }
    }

    /// Init the CoreData
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Coins")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}
