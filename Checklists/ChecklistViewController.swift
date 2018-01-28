//
//  ViewController.swift
//  Checklists
//
//  Created by Neil Houselander on 14/01/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var row0Item :CheckListItem
    var row1Item :CheckListItem
    var row2Item :CheckListItem
    var row3Item :CheckListItem
    var row4Item :CheckListItem
    
    
    required init?(coder aDecoder: NSCoder) {
        
        row0Item = CheckListItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        
        row1Item = CheckListItem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        
        row2Item = CheckListItem()
        row2Item.text = "Learn iOS development"
        row2Item.checked = false
        
        row3Item = CheckListItem()
        row3Item.text = "Soccer practice"
        row3Item.checked = false
        
        row4Item = CheckListItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //table view methods
    //Delegate protocol method

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if indexPath.row == 0 {
                row0Item.checked = !row0Item.checked
            }
            
            if indexPath.row == 1 {
                row1Item.checked = !row1Item.checked
            }
            
            if indexPath.row == 2 {
                row2Item.checked = !row2Item.checked
            }
            
            if indexPath.row == 3 {
                row3Item.checked = !row3Item.checked
            }
            
            if indexPath.row == 4 {
                row4Item.checked = !row4Item.checked
            }
            
            configureCheckMark(for: cell, at: indexPath)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //data source protocol method, determines initial set up of the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            label.text = row0Item.text
        } else if indexPath.row == 1 {
            label.text = row1Item.text
        } else if indexPath.row == 2 {
            label.text = row2Item.text
        } else if indexPath.row == 3 {
            label.text = row3Item.text
        } else if indexPath.row == 4 {
            label.text = row4Item.text
        }
        
        configureCheckMark(for: cell, at: indexPath) //make sure the rows stay in sync - checkmarks etc.
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //helper function to determine, set local variable to true or false depending on whether row0Checked is true or false. Then applies the accessory type
    func configureCheckMark(for cell: UITableViewCell, at indexPath: IndexPath) {
        
        var isChecked = false
        
        if indexPath.row == 0 {
            isChecked = row0Item.checked
            
        } else if indexPath.row == 1 {
            isChecked = row1Item.checked
        } else if indexPath.row == 2 {
            isChecked = row2Item.checked
        } else if indexPath.row == 3 {
            isChecked = row3Item.checked
        } else if indexPath.row == 4 {
            isChecked = row4Item.checked
        }
        
        if isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }


}

