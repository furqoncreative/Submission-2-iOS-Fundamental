//
//  DatabaseHelper.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 23/08/21.
//

import CoreData

class GameFavoriteProvider {
    static let shared = GameFavoriteProvider()
    
    static var preview: GameFavoriteProvider = {
        let result = GameFavoriteProvider(inMemory: true)
        let viewContext = result.container.viewContext
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GamesFavorite")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { ( _, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
    }
    
}
