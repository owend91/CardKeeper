//
//  CardsContainer.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import Foundation

import Foundation
import CoreData

class CardsContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CardModel")
        guard let path = persistentContainer
            .persistentStoreDescriptions
            .first?
            .url?
            .path()
        else {
            fatalError("Could not find persistent container")
        }
        print("Core data: \(path)")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
