//
//  ViewController.swift
//  Checklists
//
//  Created by Neil Houselander on 14/01/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    let row0Text = "Walk the dog"
    let row1Text = "Brush my teeth"
    let row2Text = "Learn iOS development"
    let row3Text = "Soccer practice"
    let row4Text = "Eat ice cream"
    
    var row0Checked = false
    var row1Checked = false
    var row2Checked = false
    var row3Checked = false
    var row4Checked = false

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
                row0Checked = !row0Checked
            }
            
            if indexPath.row == 1 {
                row1Checked = !row1Checked
            }
            
            if indexPath.row == 2 {
                row2Checked = !row2Checked
            }
            
            if indexPath.row == 3 {
                row3Checked = !row3Checked
            }
            
            if indexPath.row == 4 {
                row4Checked = !row4Checked
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
            label.text = row0Text
        } else if indexPath.row == 1 {
            label.text = row1Text
        } else if indexPath.row == 2 {
            label.text = row2Text
        } else if indexPath.row == 3 {
            label.text = row3Text
        } else if indexPath.row == 4 {
            label.text = row4Text
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
            isChecked = row0Checked
        } else if indexPath.row == 1 {
            isChecked = row1Checked
        } else if indexPath.row == 2 {
            isChecked = row2Checked
        } else if indexPath.row == 3 {
            isChecked = row3Checked
        } else if indexPath.row == 4 {
            isChecked = row4Checked
        }
        
        if isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }


}

