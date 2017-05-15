//
//  MeetingSetupViewController.swift
//  TradeThatApp
//
//  Created by Brandon on 3/31/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
import MapKit
import CoreLocation

class MeetingSetupViewController: UIViewController {
    
    var items: Items?
    
    @IBOutlet weak var meetUpLoacationTextBox: UITextField!
    
    @IBOutlet weak var meetUpTimeTextBox: UITextField!
    
    @IBOutlet weak var Map: MKMapView!
    
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
        
        let location = CLLocationCoordinate2DMake(33.749005, -84.397572)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Atlanta Police Station"
        annotation.subtitle = "200 Spring St NW, Atlanta, GA 30303"
        Map.addAnnotation(annotation)
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //     Get the new view controller using segue.destinationViewController.
        //     Pass the selected object to the new view controller.
        
        if segue.identifier == "toTradeSpot"{
            let v = segue.destinationViewController as! TradeSpotViewController
            
            v.items = items
        }
        if segue.identifier == "toPaySpot"{
            let v = segue.destinationViewController as! MapPayPalPortalViewController
            
            v.items = items
        }
    }

    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
}
