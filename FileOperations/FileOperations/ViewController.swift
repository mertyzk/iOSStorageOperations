//
//  ViewController.swift
//  FileOperations
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func writeButton(_ sender: Any) {
        
        let message = textField.text! // msj alındı
        // kayıt yapılacak alan seçildi (first)
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let filePath = directory.appendingPathComponent("myfile.txt") // dosya eklendi
            
            do {
                try message.write(to: filePath, atomically: false, encoding: String.Encoding.utf8) // kaydedildi
                textField.text = ""
            }catch{
                print("Write Error!")
            }
        }
        
    }
    
    @IBAction func readButton(_ sender: Any) {
        
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let filePath = directory.appendingPathComponent("myfile.txt") // dosya eklendi
            
            do {
                textField.text = try String(contentsOf: filePath, encoding: String.Encoding.utf8)
            }catch{
                print("Read Error!")
            }
        }
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let filePath = directory.appendingPathComponent("myfile.txt") // dosya eklendi
            
            if FileManager.default.fileExists(atPath: filePath.path){
                do {
                    try FileManager.default.removeItem(at: filePath)
                    textField.text = ""
                }catch{
                    print("Delete Error!")
                }
            }
        }
    }
    
    @IBAction func saveImageButton(_ sender: Any) {
        
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let filePath = directory.appendingPathComponent("myimage.png") // dosya eklendi
            let imagePath = UIImage(named: "rocket")
            
            do {
                try imagePath?.pngData()?.write(to: filePath)
            }catch{
                print("Image Write Error!")
            }
        }
        
        
    }
    
    @IBAction func showImageButton(_ sender: Any) {
        
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let filePath = directory.appendingPathComponent("myimage.png") // dosya eklendi
            
            self.imageView.image = UIImage(contentsOfFile: filePath.path)
        }
    }
    
    @IBAction func deleteImageButton(_ sender: Any) {
        
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let filePath = directory.appendingPathComponent("myimage.png") // dosya eklendi
            
            if FileManager.default.fileExists(atPath: filePath.path){
                do {
                    try FileManager.default.removeItem(at: filePath)
                }catch{
                    print("Image Delete Error!")
                }
            }
        }
    }
    
}

