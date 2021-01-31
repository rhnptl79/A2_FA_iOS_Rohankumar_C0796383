//
//  CoreData.swift


import Foundation
import CoreData

class CoreData {
    
    static let sharedCoreData = CoreData()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "A2_FA_iOS_Rohankumar_C0796383")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Undistinguished error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Undistinguished error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
