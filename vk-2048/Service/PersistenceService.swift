//
// Created by Alikhan Nurlanovich on 2019-05-18.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class PersistenceService {

    var db: OpaquePointer?
    
    init() {
        createFile()
        createTable()
    }
    
    private func createFile() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Tiles.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    private func createTable(){
        if sqlite3_exec(
            db,
            "CREATE TABLE IF NOT EXISTS TILES (" +
            "ID INTEGER PRIMARY KEY AUTOINCREMENT," +
            "X INTEGER," +
            "Y INTEGER," +
            "NUMBER INTEGER)",
            nil,
            nil,
            nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertTiles(tiles: [Tile]) {
        var queryStatement: OpaquePointer?
        let queryString: String = "INSERT INTO TILES (X, Y, NUMBER) VALUES (?,?,?)"
        let deleteString: String = "DELETE FROM TILES"
        
        if sqlite3_exec(db, deleteString, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error deleting rows: \(errmsg)")
        }
        
        tiles.forEach({
            tile in
            
            let number = tile.number == nil ? 0 : tile.number!
            
            if sqlite3_prepare(db, queryString, -1, &queryStatement, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            
            if sqlite3_bind_int(queryStatement, 1, Int32(tile.position.x)) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
            if sqlite3_bind_int(queryStatement, 2, Int32(tile.position.y)) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
            if sqlite3_bind_int(queryStatement, 3, Int32(number)) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
            if sqlite3_step(queryStatement) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting hero: \(errmsg)")
                return
            }
        })
        sqlite3_finalize(queryStatement)
    }
    
    func getTiles() -> [Tile] {
        var tiles: [Tile] = [Tile]()
        let queryString = "SELECT * FROM TILES"
        var queryStatement:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &queryStatement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return [Tile]()
        }
        
        while(sqlite3_step(queryStatement) == SQLITE_ROW){
            
            let x = sqlite3_column_int(queryStatement, 1)
            let y = sqlite3_column_int(queryStatement, 2)
            let number = sqlite3_column_int(queryStatement, 3)
            
            tiles.append(Tile(position: CGPoint(x: Int(x), y: Int(y)), number: number == 0 ? nil : Int(number)))
        }
        
        sqlite3_finalize(queryStatement)
        
        return tiles
    }
    
    func closeDB() {
        sqlite3_close(db)
    }
    
}
