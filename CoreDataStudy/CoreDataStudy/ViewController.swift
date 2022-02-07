//
//  ViewController.swift
//  CoreDataStudy
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    var personsList = [Persons]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataSave()
        //dataRead()
        //dataDelete()
        //dataRead()
        //dataUpdate()
        //dataRead()
        
        dataReadSorted()
    }
    
    func dataSave(){
        let person = Persons(context: context)
        person.person_name = "Kylie"
        person.person_age = 52
        
        appDelegate.saveContext()
    }
    
    func dataRead() {
        do {
            personsList = try context.fetch(Persons.fetchRequest())
        } catch {
            print("Data reading ERROR!")
        }
        
        for person in personsList{
            print("Name: \(person.person_name!) - Age: \(person.person_age)")
        }
    }
    
    func dataDelete() {
        let person = personsList[1]
        context.delete(person)
        appDelegate.saveContext()
    }
    
    func dataUpdate() {
        let person = personsList[1]
        person.person_name = "New Name - Update"
        person.person_age = 333
        
        appDelegate.saveContext()
    }
    
    func dataReadSorted() {
        
        let fetchRequest:NSFetchRequest<Persons> = Persons.fetchRequest()
        let sorted = NSSortDescriptor(key: #keyPath(Persons.person_age), ascending: true)
        
        fetchRequest.sortDescriptors = [sorted]
        
        do {
            personsList = try context.fetch(fetchRequest)
        } catch {
            print("Data reading ERROR!")
        }
        
        for person in personsList{
            print("Name: \(person.person_name!) - Age: \(person.person_age)")
        }
    }


}

