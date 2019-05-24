//
//  AppDelegate.swift
//  vk-2048
//
//  Created by Alikhan Nurlanovich on 2019-05-08.
//  Copyright © 2019 Chainless. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let persistenceService: PersistenceService = PersistenceService()
    private var tiles: [Tile] = [Tile]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.tiles = persistenceService.getTiles()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        persistenceService.insertTiles(tiles: tiles)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        persistenceService.insertTiles(tiles: tiles)
        persistenceService.closeDB()
    }
    
    func setTiles(tiles: [Tile]) {
        self.tiles = tiles
    }
    
    func getTiles() -> [Tile] {
        return self.tiles
    }
}
