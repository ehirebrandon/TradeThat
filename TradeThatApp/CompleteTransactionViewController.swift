//
//  CompleteTransactionViewController.swift
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

class CompleteTransactionViewController: UIViewController {
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var items: Items?
    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    @IBAction func hideKB(sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    @IBAction func doneButton(sender: AnyObject) {
        
//       let request = NSFetchRequest(entityName: "Items")
//        let fetchItem = try! moContext.executeFetchRequest(request)
//        items = fetchItem as! [Items]
//        
//        let predicate = NSPredicate(format: "count == %@", "3")
//        
//        request.predicate = predicate
//        
//        do{
//            let fetchRequest = try! self.moContext.executeFetchRequest(request)
//            
//            self.items = fetchRequest as! [Items]
        
//            items[0].sold = true
  
        
        items?.sold = true
   
    
        
    }
    
    
}
