//
//  TableViewCellDescriptionViewController.swift
//  TradeThatApp
//
//  Created by Brandon on 3/31/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit

class TableViewCellDescriptionViewController: UIViewController {
    
    var items: Items?
    var titlex: String?
    var subTitlex: String?
    var descx: String?
    var tradeForx: String?
    var soldForx: String?
    
    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    @IBOutlet weak var myTitle: UILabel?
    @IBOutlet weak var mySub: UILabel?
    @IBOutlet weak var tradeFor: UIButton?
    @IBOutlet weak var soldFor: UIButton?
    
    @IBOutlet weak var myDescription: UITextView!
    
    override func viewDidAppear(animated: Bool) {
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titlex = items?.title
        subTitlex =  items?.subTitle
        descx = items?.desc
        tradeForx = items?.tradeFor
        soldForx = items?.sellFor
        
        
        if titlex != nil{
            myTitle!.text = titlex
        }
        if subTitlex != nil{
            mySub!.text = subTitlex
        }
        if descx != nil{
            myDescription!.text = descx
        }
        
        if tradeForx != nil{
            tradeFor!.setTitle(tradeForx, forState: UIControlState.Normal)
          
        }
        if soldForx != nil{
            soldFor!.setTitle(soldForx, forState:  UIControlState.Normal)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //     Get the new view controller using segue.destinationViewController.
        //     Pass the selected object to the new view controller.
        
        if segue.identifier == "sellToMeetup"{
            let v = segue.destinationViewController as! MeetingSetupViewController
  
            v.items = items
        }
        if segue.identifier == "tradeToMeetup"{
            let v = segue.destinationViewController as! MeetingSetupViewController
            
            v.items = items
        }
    }

    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
}
