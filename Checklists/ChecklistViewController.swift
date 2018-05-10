//
//  ViewController.swift
//  Checklists
//
//  Created by Neil Houselander on 14/01/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    

    
    func addItemViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: ItemDetailV, didFinishAdding item: CheckListItem) {
        
        let newRowIndex = items.count //how many items in array - allows us to place new thing at the end
        items.append(item) //grabs the item from the other viewController here (its the "item" bit)
        let indexPath = IndexPath(row: newRowIndex, section: 0) //sets up the last item in the array
        let indexPathsArray = [indexPath]
        tableView.insertRows(at: indexPathsArray, with: .automatic) //insert a new row at the end of the list
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func addItemViewController(_ controller: ItemDetailV, didFinishEditing item: CheckListItem) {
        
        if let index = items.index(of: item) { //set index to equal the array item with index of the checklist item
            let indexPath = IndexPath(row: index, section: 0) //make sure we are looking at the same row in the table
            if let cell = tableView.cellForRow(at: indexPath) { //look at the cell with the same index number
                configureText(for: cell, with: item) //set the title of the cell using helper method
            }
        }
        navigationController?.popViewController(animated: true)
        
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
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        } else if segue.identifier == "editItemSegue" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
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
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    //helper to take the cell passed in & set the text to the text from the items array
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}

