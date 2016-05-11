//
//  AddGroceryVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 5/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class AddGroceryVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var quantityTxtField: UITextField!
    
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        quantityTxtField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return Int(string) != nil
    }
    
    @IBAction func saveBtnAction(sender: AnyObject) {
        
        let groceryDictionary = ["name":nameTxtField.text!,
                                "quantity":quantityTxtField.text!,
                                "description":descriptionTxtField.text!];
        
        if var groceryListArray = NSUserDefaults.standardUserDefaults().objectForKey("defaultList") as? [[String : String]]{
            
                groceryListArray.append(groceryDictionary)
                NSUserDefaults.standardUserDefaults().setObject(groceryListArray, forKey: "defaultList")

            
        } else {
        
            var groceryListArray = [[String : String]]()
            
            groceryListArray.append(groceryDictionary)
                NSUserDefaults.standardUserDefaults().setObject(groceryListArray, forKey: "defaultList")
                
        }
       
        NSUserDefaults.standardUserDefaults().synchronize()
        navigationController?.popToRootViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
