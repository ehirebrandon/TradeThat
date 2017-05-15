//
//  ListingViewController.swift
//  TradeThatApp
//
//  Created by Brandon on 3/31/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
import CoreData

class ListingViewController: UIViewController{
    
    var img: UIImage?
    var itemsToAdd: Items?
    var items: Items?
    var user: User?
    
    var itemsArray = [Items]()
    var userArray = [User]()
    var count: Int = 0
    
    var setArray: NSArray?
    
    
    // Errors Enum
    enum SavingError: ErrorType{
        case Error
    }
    @IBOutlet weak var nameAction: UIButton!
    @IBAction func nameAction(sender: AnyObject) {
    }
    
    var nameAct: String?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subTitleTextField: UITextField!
    @IBOutlet weak var tradeForTextField: UITextField!
    @IBOutlet weak var sellForTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    // Access to ManagedObjectContext
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Access to Facebook Request
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
    
    
    @IBAction func listButton(sender: AnyObject) {
        // Get the description of the entity
        
        print("Hey I am count\(self.count)")
        if count == 0{
            print("hey im zero")
            //            let itemsDescription = NSEntityDescription.entityForName("Items", inManagedObjectContext: moContext)
            //            // Then, We Create the Managed Object to be inserted to core data
            //            items = Items(entity: itemsDescription!, insertIntoManagedObjectContext: moContext)
        }
     
        
//        if itemsToAdd == nil{
            print("hey im nil")
            let itemsDescription = NSEntityDescription.entityForName("Items", inManagedObjectContext: moContext)
            // Then, We Create the Managed Object to be inserted to core data
            itemsToAdd = Items(entity: itemsDescription!, insertIntoManagedObjectContext: moContext)
//        }
        
        let title = titleTextField.text
        let subTitle = subTitleTextField.text
        let tradeFor = tradeForTextField.text
        let sellFor = sellForTextField.text
        let description = descriptionTextField.text
        
        
        itemsToAdd!.setValue(title, forKey: "title")
        itemsToAdd!.setValue(subTitle, forKey: "subTitle")
        itemsToAdd!.setValue(tradeFor, forKey: "tradeFor")
        itemsToAdd!.setValue(sellFor, forKey: "sellFor")
        itemsToAdd!.setValue(description, forKey: "desc")
        

        let request = NSFetchRequest(entityName: "Items")
        
        //let stringCount = String(self.count)
        
        // predicate like a where clause in sql
        //let predicate = NSPredicate(format: "count == %@", stringCount)
        
        //print("predicate is \(predicate)")
        
        //request.predicate = predicate
        do{
            let fetchStore = try! self.moContext.executeFetchRequest(request)
            self.itemsArray = fetchStore as! [Items]
            
            print("the count is \(self.itemsArray.count)")
            
//            itemsArray[0].setValue(title, forKey: "title")
//            itemsArray[0].setValue(subTitle, forKey: "subTitle")
//            itemsArray[0].setValue(tradeFor, forKey: "tradeFor")
//            itemsArray[0].setValue(sellFor, forKey: "sellFor")
//            itemsArray[0].setValue(description, forKey: "desc")
            
            
        }
        
       print("heyI'mitemsarray\(itemsArray.count)")
        
        itemsToAdd!.setValue((self.itemsArray.count), forKey: "countID")
        
//        if img == nil{
//
//            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//         
//            
//          
//            
//            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
//            switch action.style{
//            case .Default:
//            print("default")
//            
//            case .Cancel:
//            print("cancel")
//            
//            case .Destructive:
//            print("destructive")
//            }
//            }))
//            
//        }
      
        let imgData = NSData(data: UIImageJPEGRepresentation(img!, 1)!)
            itemsToAdd!.setValue(imgData, forKey: "image")
     
        
        itemsToAdd!.user = user
        
        
        
        
        //user?.addItemsObject(items!)
        
        // Finally we issue the command to save the data
        let err: NSError?
        
        // Save The Object
        do{
            try! moContext.save()
            let a = UIAlertView(title: "Success", message: "Your record has been saved", delegate: nil, cancelButtonTitle: "OK")
            a.show()
        }catch SavingError.Error{
            print("wrong")
            let a = UIAlertView(title: "Error", message: err!.localizedFailureReason, delegate: nil, cancelButtonTitle: "OK")
            a.show()
        }
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        // dismiss ViewController
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        req.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if(error == nil)
            {
                print("hello my name is \(result["name"])")
//                self.nameAction.titleLabel?.text = result["name"] as? String
                
                self.nameAction.setTitle((result["name"] as! String), forState: UIControlState.Normal)
                print("result\(result)")
            }else{
                print("error\(error)")
            }
        })
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //     Get the new view controller using segue.destinationViewController.
        //     Pass the selected object to the new view controller.
        
        if segue.identifier == "uploadImage"{
            if segue.identifier == "listButton"{
                let v = segue.destinationViewController as! ListingSucceedViewController
                v.item = itemsArray[0]
                
                
            }
         
            req.startWithCompletionHandler({
                (connection, result, error: NSError!) -> Void in
                if(error == nil)
                {
                    print("hello my email is \(result["email"])")
                    self.nameAct = result["email"] as? String
                    print("result\(result)")
                    
                    let request = NSFetchRequest(entityName: "User")
                    
                    // predicate like a where clause in sql
                    let predicate = NSPredicate(format: "email == %@", self.nameAct!)
                    
                    print("predicate is \(predicate)")
                    
                    request.predicate = predicate
                    do{
                        let fetchStore = try self.moContext.executeFetchRequest(request)
                        self.userArray = fetchStore as! [User]
                        
                        print("the count is \(self.userArray.count)")
                        
                        let v = segue.destinationViewController as! UploadViewController
                        
                        v.user = self.userArray[0]
                        
                    }catch{
                        fatalError("bad things happen\(error)")
                    }
                }else{
                    print("error\(error)")
                }
            })
            
            
        }
     
            
        
        
        
    }
    
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    
    
    
}
