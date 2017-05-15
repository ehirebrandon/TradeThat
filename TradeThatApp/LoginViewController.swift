//
//  LoginViewController.swift
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


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var button: UIButton!
    @IBAction func button(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.hidden = true
        
        // Do any additional setup after loading the view.
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else{
            print("Logged in..")
            button.hidden = false
        }
        var loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        loginButton.center = CGPoint(x: 160, y: 400)
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        if(error == nil){
            print("Complete login")
            self.performSegueWithIdentifier("showNew", sender: self)
            button.hidden = false
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        button.hidden = true
        print("User logged out..")
    }
    
    

    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
   
}
