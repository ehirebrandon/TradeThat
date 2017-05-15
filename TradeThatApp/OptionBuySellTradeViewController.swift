//
//  OptionBuySellTradeViewController.swift
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


class OptionBuySellTradeViewController: UIViewController {
    
    var nameAct: String?
    
//    // CoreData ModelObjectContext
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var user: User?
    
    // Facebook Request
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
    
    
    @IBOutlet weak var nameAction: UIButton!
    @IBAction func nameAction(sender: AnyObject) {
    }
    
    @IBOutlet weak var buy: UIButton!
    @IBAction func buyAction(sender: AnyObject) {
    }
    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        req.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if(error == nil)
            {
                print("hello my name is \(result["name"])")
                
                       self.nameAction.setTitle((result["name"] as! String), forState: UIControlState.Normal)
//                self.nameAction.titleLabel?.text = (result["name"] as? String)
                print("result\(result)")
                
                print("hello my email is \(result["email"])")
                self.nameAct = result["email"] as? String
                print("result\(result)")
                
                if self.user == nil{
                    print("hey im nil")
                    let itemsDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: self.moContext)
                    // Then, We Create the Managed Object to be inserted to core data
                    self.user = User(entity: itemsDescription!, insertIntoManagedObjectContext: self.moContext)
                }
                
                print("testing if it's email \(self.user?.email)")
                self.user?.email = self.nameAct
                print("testing if it's email again \(self.user?.email)")
                
                do{
                    try! self.moContext.save()
                    
                }
                
            }else{
                print("error\(error)")
            }
        })
    }
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
}
