//
//  AccountViewController.swift
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

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    var itemsArray = [Items]()
    
    var countAct: String?
    // Access to ManagedObjectContext
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Access to Facebook
    //Request
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")

    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print("ah ha \(self.itemsArray.count)")
        
        let request = NSFetchRequest(entityName: "Items")
        
        // predicate like a where clause in sql
        let predicate = NSPredicate(format: "countID < %@", "5")
        
        print("predicate is xxx \(predicate)")
        
        request.predicate = predicate
        
        
        
        do{
            let fetchStore = try self.moContext.executeFetchRequest(request)
            self.itemsArray = fetchStore as! [Items]
            
            print("the count is \(self.itemsArray.count)")
            
             //print("ah again \(self.countAct)")
            
        }catch{
            fatalError("bad things happen\(error)")
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
    



    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
       return itemsArray.count
    }
//
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
//    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = (tableView === self.tableView) ? "itemsCell" : "boughtCell"
        
        
        
        if (tableView === self.tableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
           
            cell.textLabel?.text = itemsArray[indexPath.item].valueForKey("title") as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
            
            cell.textLabel?.text = ""
                
              //  itemsArray[indexPath.item].valueForKey("title") as? String
            return cell
        }
    }
    
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }



}
