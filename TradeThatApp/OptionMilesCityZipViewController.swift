//
//  OptionMilesCityZipViewController.swift
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

class OptionMilesCityZipViewController: UIViewController{
    
    
    // Facebook Request
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
    
    
    @IBOutlet weak var milesButton: UIButton!
    @IBAction func milesButton(sender: AnyObject) {
        self.milesButton.hidden = true
    }
    
    @IBOutlet weak var cityButton: UIButton!
    @IBAction func cityButton(sender: AnyObject) {
        self.cityButton.hidden = true
    }
    
    @IBOutlet weak var zipButton: UIButton!
    @IBAction func zipButton(sender: AnyObject) {
        self.zipButton.hidden = true
    }
    
    
    @IBOutlet weak var nameAction: UIButton!
    @IBAction func nameAction(sender: AnyObject) {
    }
    
    @IBAction func feelTapKB(sender: AnyObject) {
        self.view.endEditing(true)
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
                //                self.nameAction.titleLabel?.text = result["name"] as? String
                print("result\(result)")
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
