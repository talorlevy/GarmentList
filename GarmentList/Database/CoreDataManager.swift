//
//  CoreDataManager.swift
//  UserRegistrationForm
//
//  Created by Talor Levy on 2/18/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iOSTechnicalAssessment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Persistent container failure: \(error)")
            }
        })
        return container
    }()
    
    func fetchGarmentsFromCoreData() -> ([Garment]) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error
                fatalError("Save context failure: \(error)")
            }
        }
    }
    
    func addGarment(garment: Garment) {
        let context = persistentContainer.viewContext
        CoreDataManager.shared.saveContext(context: context)
    }
    
    func deleteGarment(garment: Garment) {
        persistentContainer.viewContext.delete(garment)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed: \(error)")
        }
    }
    
    func updateGarment(garment: Garment, name: String) {
        let context = persistentContainer.viewContext
        garment.name = name
        saveContext(context: context)
    }
}
