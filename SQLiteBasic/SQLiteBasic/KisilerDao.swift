//
//  KisilerDao.swift
//  SQLiteBasic
//
//  Created by Macbook Air on 7.02.2022.
//

import Foundation

class KisilerDao{
    let db:FMDatabase?
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("kisilergiris.sqlite")
        
        db = FMDatabase(path: dbURL.path)
    }
    
    func kisiAdd(kisi_ad:String,kisi_yas:Int){
        db?.open()
        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_yas) VALUES (?,?)", values: [kisi_ad,kisi_yas])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func kisiDelete(kisi_id:Int){
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func kisiUpdate(kisi_id:Int,kisi_ad:String,kisi_yas:Int){
        db?.open()
        do {
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad = ?,kisi_yas = ? WHERE kisi_id = ?", values: [kisi_ad,kisi_yas,kisi_id])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func getByAll() -> [Kisiler]{
        var list = [Kisiler]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            while result.next() {
                let kisi = Kisiler(kisi_id: Int(result.string(forColumn: "kisi_id"))!
                    , kisi_ad: result.string(forColumn: "kisi_ad")!
                    , kisi_yas: Int(result.string(forColumn: "kisi_yas"))!)
            
                list.append(kisi)
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        return list
    }
    
    func getByControl(kisi_ad:String) -> Int{
        var total = 0
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT COUNT(*) AS result FROM kisiler WHERE kisi_ad = ?", values: [kisi_ad])
            while result.next() {
                total = Int(result.string(forColumn:"result"))!
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        
        return total
    }
    
    func getBySearch(kisi_ad:String) -> [Kisiler]{
        var list = [Kisiler]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like '%\(kisi_ad)%'", values: nil)
            while result.next() {
                let kisi = Kisiler(kisi_id: Int(result.string(forColumn: "kisi_id"))!
                    , kisi_ad: result.string(forColumn: "kisi_ad")!
                    , kisi_yas: Int(result.string(forColumn: "kisi_yas"))!)
                
                list.append(kisi)
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        
        return list
    }
    
    func getById(kisi_id:Int) -> Kisiler{
        var list = Kisiler()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
            while result.next() {
                list = Kisiler(kisi_id: Int(result.string(forColumn: "kisi_id"))!
                    , kisi_ad: result.string(forColumn: "kisi_ad")!
                    , kisi_yas: Int(result.string(forColumn: "kisi_yas"))!)
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        
        return list
    }
    
    func getByRandom() -> [Kisiler]{
        var list = [Kisiler]()
        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM kisiler ORDER BY RANDOM() LIMIT 1", values: nil)
            while result.next() {
                let kisi = Kisiler(kisi_id: Int(result.string(forColumn: "kisi_id"))!
                    , kisi_ad: result.string(forColumn: "kisi_ad")!
                    , kisi_yas: Int(result.string(forColumn: "kisi_yas"))!)
                
                list.append(kisi)
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        
        return list
    }
    
    
    
}
