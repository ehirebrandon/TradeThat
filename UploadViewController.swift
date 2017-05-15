//
//  UploadViewController.swift
//  TradeThatApp
//
//  Created by Brandon on 4/7/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var img: UIImage?
    var user: User?
    
    var userArray = [User]()
    var items: Items?
    
    var itemsArray = [Items]()
    var setArray: NSArray?
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Errors Enum
    enum SavingError: ErrorType{
        case Error
    }
    
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var photoLibrary: UIButton!
    
    @IBAction func returnToListing(sender: AnyObject) {
        // save the presenting ViewController
        let presentingViewController :UIViewController! = self.presentingViewController
        // dismiss ViewController
        self.dismissViewControllerAnimated(false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    @IBAction func camera(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func photoLibrary(sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func submit(sender: AnyObject) {
           }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageDisplay.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the description of the entity
     

        let request = NSFetchRequest(entityName: "User")
        do{
            let fetchItem = try! moContext.executeFetchRequest(request)
            userArray = fetchItem as! [User]
            
            setArray = (userArray[0].items?.allObjects)! as NSArray
//
//            items?.setValue((setArray!.count), forKey: "count")
//            
//            print("hi\(setArray?.count)")
//            
        }catch{
            fatalError("bad things happen\(error)")
        }
        
        
        
        // save the managed object into the storage
       // let img = imageDisplay.image
        
//        let imgData = NSData(data: UIImageJPEGRepresentation(img!, 1)!)
//        
        
//        items?.setValue(imgData, forKey: "image")
//        items?.user = user
//        
        // Finally we issue the command to save the data
        let err: NSError?
        
        // Save The Object
        do{
            try! moContext.save()
            let a = UIAlertView(title: "Success", message: "Your record has been saved", delegate: nil, cancelButtonTitle: "OK")
            a.show()
        }catch SavingError.Error{
            print("wrong")
            let a = UIAlertView(title: "Error", message: err!.localizedFailureReason, delegate: nil, cancelButtonTitle: "OK")
            a.show()
        }

 
        
        
        if segue.identifier == "submitToListing"{
            let v = segue.destinationViewController as! ListingViewController
            
            v.img = imageDisplay.image
            print("setarraycount\(setArray!.count)")
                        v.count = setArray!.count
            
        }
    }
    
    
   
    
    
}
