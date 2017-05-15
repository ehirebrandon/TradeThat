//
//  ThingsToBuyViewController.swift
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

class ThingsToBuyViewController: UITableViewController {
    // Access to ManagedObjectContext
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var items = [Items]()
    //var itemx = [Items]()
    
  
    @IBOutlet weak var topToolBar: UINavigationItem!
    
    enum SavingError: ErrorType{
        case Error
    }
    
    @IBAction func backbutton(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        
        let request = NSFetchRequest(entityName: "Items")
        
        do{
            let fetchStore = try moContext.executeFetchRequest(request)
            items = fetchStore as! [Items]
            
            self.tableView.reloadData()
            
        }catch{
            fatalError("bad things happen\(error)")
        }
        
        
        
        
        
//        for item in items{
//            if item.sold != true{
//                itemx.append(item)
//            }
//        }
    }
    
    func filterItems(searchText: String){
        let request = NSFetchRequest(entityName: "Items")
        
        // predicate like a where clause in sql
        let predicate = NSPredicate(format: "title contains %@", searchText)
        
        request.predicate = predicate
        
        do{
            let fetchStore = try moContext.executeFetchRequest(request)
            items = fetchStore as! [Items]
            
            self.tableView.reloadData()
            //
            //            let predicate1 = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [predicate, predicate])
            //
            //            let request.predicate = predicate1
            //
            
        }catch{
            fatalError("bad things happen\(error)")
        }
        
    }
    
    
    @IBAction func searchRecords(sender: AnyObject) {
        // create the alert controller
        let v = UIAlertController(title: "Search", message: "Enter enter part of store name", preferredStyle: UIAlertControllerStyle.Alert)
        
        // Add the text field
        v.addTextFieldWithConfigurationHandler { (itemName: UITextField) -> Void in
            
            itemName.placeholder = "Item Name"
        }
        
        // Create teh button - Alert Action
        let okAc = UIAlertAction(title: "Search", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            let itemName = v.textFields![0] as! UITextField
            
            self.filterItems(itemName.text!)
            
            v.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        // Add it to the controller
        v.addAction(okAc)
        
        // only one cancel action style allowed
        let cancelAc = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            v.dismissViewControllerAnimated(true, completion: nil)
        }
        
        v.addAction(cancelAc)
        
        presentViewController(v, animated: true, completion: nil)
        
        
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        var cell = UITableViewCell()
        
        if item.sold != true{
        cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        print("hello")
        // Configure the cell...
        
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subTitle
            cell.imageView?.image = UIImage(data: item.image!)
            
        }else{
              cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.textColor = UIColor.redColor()
            cell.detailTextLabel?.textColor = UIColor.redColor()
            
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subTitle
            cell.imageView?.image = UIImage(named: "sold")
            
            
        }
//        }
        
        
        
        
        return cell
    }
    

    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
      
        
        return items.count
    }
    
    
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //     Get the new view controller using segue.destinationViewController.
        //     Pass the selected object to the new view controller.
        
        if segue.identifier == "toDesc"{
            let v = segue.destinationViewController as! TableViewCellDescriptionViewController
            let indexpath = self.tableView.indexPathForSelectedRow
            let row  = indexpath?.row
            
           v.items = items[row!]
        }
    }
}
