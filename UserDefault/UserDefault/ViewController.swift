//
//  ViewController.swift
//  UserDefault
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let standart = UserDefaults.standard
        
        standart.set("John", forKey: "name")
        standart.set("Nayada", forKey: "surname")
        standart.set(25, forKey: "age")
        standart.set(true, forKey: "married")
        
        let friendList = ["Benedict","Drew","David","Alexander","Jack","Stewart"]
        standart.set(friendList, forKey: "friendlist")
        
        let cityDictionary:[String:String] = ["06":"Ankara","17":"Çanakkale"]
        
        standart.set(cityDictionary, forKey: "dictionary")
        
        //Data reading
        
        let name = standart.string(forKey: "name") ?? "null"
        let age = standart.integer(forKey: "age")
        let surname = standart.string(forKey: "surname")
        let married = standart.string(forKey: "married")

        print(name,age,surname!,married!)
        
        let list = standart.array(forKey: "friendlist") as? [String] ?? [String]()
        print(list[1])
        
        let dict = standart.dictionary(forKey: "dictionary") as? [String:String] ?? [String:String]()
        print(dict["17"]!)
        
        //Data delete
        
        standart.removeObject(forKey: "name")
        
        //Data update
        
        standart.set("New Nayada", forKey: "surname")
        let surname2 = standart.string(forKey: "surname")
        print(surname2!)
        
    }


}

