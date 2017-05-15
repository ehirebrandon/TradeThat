//
//  ListingSucceedViewController.swift
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
import Foundation

class ListingSucceedViewController: UIViewController {
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var img: UIImage?
    var items = [Items]()
    var user = [User]()
    var item: Items?
    
  
    var titlex: String?
    var subTitlex: String?
    var descx: String?
    var tradeForx: String?
    var soldForx: String?
    
    @IBOutlet weak var myTitle: UILabel?
    @IBOutlet weak var tradeFor: UIButton?
    @IBOutlet weak var soldFor: UIButton?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func backButton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
    
    @IBOutlet weak var nameAction: UIButton!
    @IBAction func nameAction(sender: AnyObject) {
    }
    
    override func viewDidAppear(animated: Bool) {
        let request = NSFetchRequest(entityName: "Items")
        
        let fetchItem = try! moContext.executeFetchRequest(request)
        items = fetchItem as! [Items]
        
        let StringCount = String(items.count)
        
        let newRequest = NSFetchRequest(entityName: "Items")
        
        let predicate = NSPredicate(format: "countID == %@", StringCount)
        
        newRequest.predicate = predicate
        
        
        
        do{
            let newFetch = try! self.moContext.executeFetchRequest(newRequest)
            
            var imgData = (newFetch as! [Items])[0].valueForKey("image")

//            let imgData = setArray[items.count].valueForKey("image")
//            
//            print(setArray.count-1)
//            print(setArray[setArray.count-1].valueForKey("count"))
//            if imgData != nil{
                let img = UIImage(data: imgData as! NSData)
                imageView.image = img
//            }
            
            
            
        }catch{
            fatalError("bad things happen\(error)")
        }
       
        
//        let imgData =
    }
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        titlex = item?.title
        tradeForx = item?.tradeFor
        soldForx = item?.sellFor
        
        if titlex != nil{
            myTitle!.text = titlex
        }
        if tradeForx != nil{
            tradeFor!.setTitle(tradeForx, forState: UIControlState.Normal)
            
        }
        if soldForx != nil{
            soldFor!.setTitle(soldForx, forState:  UIControlState.Normal)
        }
        
        
        
        
        
        
        
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        if segue.identifier == "editStore"{
        //            let v = segue.destinationViewController as! ViewController
        //            let indexpath = self.tableView.indexPathForSelectedRow
        //            let row  = indexpath?.row
        //
        //            v.store = stores[row!]
        //        }
    }
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    
    
}
