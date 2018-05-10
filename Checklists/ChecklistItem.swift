//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Neil Houselander on 28/01/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    
    var text:String = ""
    var checked:Bool = false
    
    func toggleChecked() {
        
        checked = !checked
    }
}
