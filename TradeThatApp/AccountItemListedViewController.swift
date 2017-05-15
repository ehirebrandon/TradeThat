//
//  AccountItemListedViewController.swift
//  TradeThatApp
//
//  Created by Brandon on 3/31/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
class AccountItemListedViewController: UIViewController {
    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }

    @IBOutlet weak var nameAction: UIButton!
    
    @IBAction func nameAction(sender: AnyObject) {
    }
    
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        req.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if(error == nil)
            {
                print("hello my name is \(result["name"])")
                self.nameAction.titleLabel?.text = result["name"] as? String
                print("result\(result)")
            }else{
                print("error\(error)")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }

}
