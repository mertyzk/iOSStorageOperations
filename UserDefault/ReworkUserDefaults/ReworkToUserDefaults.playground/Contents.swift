import UIKit
import Foundation

let userDatas = UserDefaults.standard
userDatas.set("Gibi", forKey: "FavoriteShow")
userDatas.string(forKey: "FavoriteShow")
userDatas.object(forKey: "FavoriteShow")

userDatas.set(3.14, forKey: "pi")
userDatas.float(forKey: "pi")
userDatas.object(forKey: "pi")

userDatas.set(true, forKey: "password")
userDatas.bool(forKey: "password")

userDatas.set(Date(), forKey: "TimeofLogin")
userDatas.object(forKey: "TimeofLogin")

let numbers = [1,2,3,4,5,6]
userDatas.set(numbers, forKey: "numbers")
let newNumbers : [Int] = userDatas.array(forKey: "numbers") as! [Int]
print(newNumbers)

let ages : [String : Int] = ["Ali" : 18, "Veli" : 20]
userDatas.set(ages, forKey: "ages")
userDatas.object(forKey: "ages")
let dictionaryData = userDatas.object(forKey: "ages") as! [String : Int]
print(dictionaryData)

/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
 
// Method 1

class Person : NSObject , NSCoding {
    func encode(with coder: NSCoder) {
        // encode = The encode converts the object into a format that can be saved in UserDefaults
        // Decode = Data of UserDefault convert to Original Object
        coder.encode(self.name, forKey: "name")
        coder.encode(self.surname, forKey: "surname")
        coder.encode(self.age, forKey: "age")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as! String
        self.surname = coder.decodeObject(forKey: "surname") as! String
        self.age = coder.decodeObject(forKey: "age") as! Int
    }
    
    var name : String
    var surname : String
    var age : Int

    
    init(name : String, surname : String, age : Int){
        self.name = name
        self.surname = surname
        self.age = age
    }
}


let p1 : Person = Person(name: "Neil", surname: "Part", age: 55)
let p2 : Person = Person(name: "John", surname: "Cain", age: 65)
let personArray = [p1,p2]

do {
    let encodeData = try NSKeyedArchiver.archivedData(withRootObject: personArray, requiringSecureCoding: false)
    UserDefaults.standard.set(encodeData, forKey: "datas1")
} catch {
    print("Error")
}


//let decodeArray = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: "datas1") as! Data) as! [Person]
//print("\(decodeArray)")


/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */

// Method 2

struct User : Codable{
    var userId : String = ""
    var userName : String = ""
    var profilePhoto : Data?
}

extension UserDefaults{
    var currentUser : User? {
        get {
            guard let userData = self.object(forKey: #function) as? Data else { return nil }
            return try? JSONDecoder().decode(User.self, from: userData)
        } set{
            guard let newUser = newValue else { return }
            if let userData = try? JSONEncoder().encode(newValue) {
                self.set(userData, forKey: #function)
            }
        }
    }
}

if (UserDefaults.standard.currentUser == nil){
    var occupant = User()
    occupant.userId = UUID().uuidString
    print(occupant.userId)
    print(occupant.userName)
}else{
    var occupent = UserDefaults.standard.currentUser
    print(occupent?.userName)
}

/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */
/* ########################################################################## */

// Method 3


struct UserDetails : Codable{
    var accountDeleted : Bool
    var userId : String
    var userAge : Int
    
    func showUser(){
        if accountDeleted {
            print("Account deleted")
        }else{
            print("Account not deleted")
        }
        print("User ID: \(self.userId)")
        print("User age: \(self.userAge)")
    }
}

do {
    var user = UserDetails(accountDeleted: true, userId: "123123", userAge: 21)
    let data = try JSONEncoder().encode(user)
    UserDefaults.standard.set(data, forKey: "data3")
} catch {
    print(error.localizedDescription)
}


do {
    if let data = UserDefaults.standard.data(forKey: "data3") {
        let incomingUser = try JSONDecoder().decode(UserDetails.self, from: data)
        print(incomingUser.userAge)
        incomingUser.showUser()
    } else {
        print("Incoming account error")
    }
} catch {
    print(error.localizedDescription)
}
