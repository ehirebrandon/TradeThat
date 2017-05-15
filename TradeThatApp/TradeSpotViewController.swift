//
//  TradeSpotViewController.swift
//  TradeThatApp
//
//  Created by Brandon on 3/31/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit

class TradeSpotViewController: UIViewController {
    
    
    var items: Items?

    
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
        
        
       
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //     Get the new view controller using segue.destinationViewController.
        //     Pass the selected object to the new view controller.
        
        if segue.identifier == "toCompleteTrade"{
            let v = segue.destinationViewController as! CompleteTransactionViewController
            
            v.items = items
        }
    
    }

    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
}
