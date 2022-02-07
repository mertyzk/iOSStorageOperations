//
//  ViewController.swift
//  SQLiteBasic
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dbCopy()
        
        //KisilerDao().kisiAdd(kisi_ad: "TestAdd", kisi_yas: 277) // kayıt
        
        //KisilerDao().kisiDelete(kisi_id: 2)
        
        KisilerDao().kisiUpdate(kisi_id: 3, kisi_ad: "NewName", kisi_yas: 99)
        
        
        var incomingList = KisilerDao().getByAll()
        
        for il in incomingList{
            print("ID: \(il.kisi_id!) - NAME: \(il.kisi_ad!) - AGE: \(il.kisi_yas!)")
        }
    }

    func dbCopy(){
        let bundlePath = Bundle.main.path(forResource: "kisilergiris", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("kisilergiris.sqlite")
        
        if fileManager.fileExists(atPath: placeToCopy.path){
            print("DB mevcut, kopyalama gereksiz.")
        }else{
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: placeToCopy.path)
            } catch{
                print(error)
            }
        }
        
        
        
    }

}

