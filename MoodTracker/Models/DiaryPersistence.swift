//
//  DiaryPersistence.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//
import Foundation
import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Diary")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("ERROR:PersistenceController \(error), \(error.userInfo)")
            }
        }
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
