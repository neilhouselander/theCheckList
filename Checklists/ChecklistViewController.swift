//
//  ViewController.swift
//  Checklists
//
//  Created by Neil Houselander on 14/01/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem) {
        
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPathsArray = [indexPath]
        tableView.insertRows(at: indexPathsArray, with: .automatic)
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        print("Item added")
        
        //create a place for the new item to be added - the end of the array is the way to go
        //create a new checklist item
        //give the item some values
        //add the new item to the existing array of items
        //create a new indexpath - where to add it to the table view
        //use the tableview insert rows method to add a new row
        
        var titles = ["Say hi to Neil", "Say hi to Kora", "fly the drone","read more of book", "go for a run" ]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        let title = titles[Int(randomNumber)]
        
        let newRowIndex = items.count
        
        let item = CheckListItem()
        item.text = title
        item.checked = true
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]

        tableView.insertRows(at: indexPaths, with: .fade)   
    }
    
    
    var items: [CheckListItem] //declared outside the initialiser so can use elsewhere
    
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [CheckListItem]()
        
        let row0Item = CheckListItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = CheckListItem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = CheckListItem()
        row2Item.text = "Learn iOS development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = CheckListItem()
        row3Item.text = "Soccer practice"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = CheckListItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = CheckListItem()
        row5Item.text = "Have some brunch"
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = CheckListItem()
        row6Item.text = "Do some push ups"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = CheckListItem()
        row7Item.text = "Run a meeting"
        row7Item.checked = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
        }
    }
    
    //table view methods
    
    //DATA SOURCE METHODS protocol method, determines initial set up of the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)

        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        
        configureCheckMark(for: cell, with: item ) //make sure the rows stay in sync - checkmarks etc.
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //removing cells from the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row) //update the model (take item select out of the array
        
        //dont need to use delete row - the tableview is being updated by the model, so once item is removed from the array just reload data and the view loses the row. BUT no nice animation
        
        //let indexPaths = [indexPath] //set up a constant for an array of index paths - in this case just the indexPath passed in from the method
        //tableView.deleteRows(at: indexPaths, with: .automatic) //delete the row - update the view
        
        
        tableView.reloadData() //this does the job of the 2 lines of code above
    }
    
    
    
    //DELEGATE protocol method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckMark(for: cell, with: item)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //HELPERS//////////////
    //helper function to determine, set local variable to true or false depending on whether row0Checked is true or false. Then applies the accessory type
    func configureCheckMark(for cell: UITableViewCell, with item: CheckListItem) {
        
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    //helper to take the cell passed in & set the text to the text from the items array
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}

