//
//  ViewController.swift
//  CoreDataSwift
//
//  Created by Bansi bhatt on 24/11/17.
//
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var userNameArr : [String] = []
    var passwordArr : [String] = []
    var appdelegate : AppDelegate! = nil
    var context : NSManagedObjectContext! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appdelegate = UIApplication.shared.delegate as! AppDelegate
        context = appdelegate.persistentContainer.viewContext
        addData(name: "Bansi", password: "bhatt")
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addData(name : String ,password : String){
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue(name,forKey : "userName")
        newUser.setValue(password, forKey: "password")

        do{
            try context.save()
            print("save")
        }catch{
            //error
        }

    }
    
    
    func fetchData(){

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        userNameArr.removeAll()
        passwordArr.removeAll()

        do{
            let results = try context.fetch(request)
         
            if results.count > 0{
             
                for result in results as! [NSManagedObject]{
                    context.delete(result)
                    if let username = result.value(forKey: "userName") as? String{
                        userNameArr.append(username)
                    }
                    if let password = result.value(forKey:"password") as? String{
                        passwordArr.append(password)
                    }
                }

            }
        }catch{
            
        }
        
        print("Name are \(userNameArr)")
        print("password are \(passwordArr)")
        
    }
    
    func deleteData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    context.delete(result)
                   try context.save()
                    print("Name are \(userNameArr)")
                    print("password are \(passwordArr)")
                }
            }
        }catch{
            
        }

    }
}

