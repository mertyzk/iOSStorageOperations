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

