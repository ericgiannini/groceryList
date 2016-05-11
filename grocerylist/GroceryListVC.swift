//
//  GroceryListVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 5/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class GroceryListVC: UITableViewController {
    
    var groceryListArray = [[String : String]]()
    
    func reloadList() {
        
        if let groceryData = NSUserDefaults.standardUserDefaults().objectForKey("defaultList") as? [[String : String]]{
            groceryListArray = groceryData
            self.tableView.reloadData()
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reloadList()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.editing = false
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groceryListArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groceryCell", forIndexPath: indexPath)

        
        let groceryData = groceryListArray[indexPath.row]
        
        cell.textLabel?.text = groceryData["name"]
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressAction:")
        
        longPressGesture.minimumPressDuration = 1.0
        
        cell.addGestureRecognizer(longPressGesture)
        
        return cell
    }
    
    func longPressAction(gesture : UILongPressGestureRecognizer) {
        
        if gesture.state == .Began {
            
            if let cell = gesture.view as? UITableViewCell{
                
                if cell.accessoryType != .Checkmark {
                    
                    cell.accessoryType = .Checkmark
                    
                } else {
                    
                    cell.accessoryType = .None
                    
                }
                
            }
            
            
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier("SegueEditGroceryVC", sender: cell)

    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            groceryListArray.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(groceryListArray, forKey: "defaultList")

           self.reloadList()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    @IBAction func editTableViewCells(sender: AnyObject) {
        
        if self.editing == true {
            
            self.editing = false
        
        } else {
            
            self.editing = true
            
        }
    }
    

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        let movableEntry = self.groceryListArray[fromIndexPath.row]
        
        groceryListArray.removeAtIndex(fromIndexPath.row)
        
        groceryListArray.insert(movableEntry, atIndex: toIndexPath.row)
        
        NSUserDefaults.standardUserDefaults().setObject(groceryListArray, forKey: "defaultList")
        
    }


    
// Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SegueEditGroceryVC", let incomingVC = segue.destinationViewController as? EditGroceryVC{
        
            if let cell = sender as? UITableViewCell, let indexPath = self.tableView.indexPathForCell(cell) {
            
                incomingVC.editGroceryData = groceryListArray[indexPath.row]
                
                incomingVC.index = indexPath.row
            }
        }
        
    }


}
