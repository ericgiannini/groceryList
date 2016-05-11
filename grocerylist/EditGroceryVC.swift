//
//  EditGroceryVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 5/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class EditGroceryVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var quantityLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var editGroceryData : [String : String]!
    
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.nameLbl.text = editGroceryData["name"]
        
//        let quantity = editGroceryData["quantity"]
//        if let quantityInteger = Int(quantity!) {
//            self.quantityLbl.text = quantity
//        } else {
//            self.quantityLbl.text = "0"
//        }
        
        self.quantityLbl.text = editGroceryData["quantity"]
        
        self.descriptionLbl.text = editGroceryData["description"]

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBtnAction(sender: AnyObject) {
        
        let groceryDictionary = ["name":nameLbl.text!,
            "quantity":quantityLbl.text!,
            "description":descriptionLbl.text!];
        
        if var groceryListArray = NSUserDefaults.standardUserDefaults().objectForKey("defaultList") as? [[String : String]]{
            
            groceryListArray.removeAtIndex(index)
            
            groceryListArray.insert(groceryDictionary, atIndex: index)
                NSUserDefaults.standardUserDefaults().setObject(groceryListArray, forKey: "defaultList")

        }
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popToRootViewControllerAnimated(true)
    }


    @IBAction func addQntyBtnAction(sender: AnyObject) {
        
        
        if Int(quantityLbl.text!) < 10000 {
            let value = Int(quantityLbl.text!)! + 1
            quantityLbl.text = "\(value)"
        }
    
    }
    

    @IBAction func minusQntyBtnAction(sender: AnyObject) {
        
        if Int(quantityLbl.text!) > 0 {
            let value = Int(quantityLbl.text!)! - 1
            quantityLbl.text = "\(value)"
        }
        
    }


}


