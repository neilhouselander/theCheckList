//
//  ViewController.swift
//  Checklists
//
//  Created by Neil Houselander on 14/01/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var items: [CheckListItem]
    
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
    
    //helper to take the cell passed in & set the text to the text form th items array
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
}

