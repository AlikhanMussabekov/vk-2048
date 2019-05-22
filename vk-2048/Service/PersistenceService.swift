//
// Created by Alikhan Nurlanovich on 2019-05-18.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistenceService {

    /*static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "_048")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    static func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func loadTiles(dimension: Int) -> [Tile] {
        let fetchRequest: NSFetchRequest<Tile> = TileModel.fetchRequest()
        var tiles = [Tile]()
        do {
            let tileModels = try context.fetch(fetchRequest)
            for tileModel in tileModels {
                if tileModel.tileValue == 0 {
                    tiles.append(Tile(position: Position(Int(tileModel.positionX), Int(tileModel.positionY)), value: nil))
                } else {
                    tiles.append(Tile(position: Position(Int(tileModel.positionX), Int(tileModel.positionY)), value: Int(tileModel.tileValue)))
                }
            }
        } catch {}

        return tiles
    }*/

}