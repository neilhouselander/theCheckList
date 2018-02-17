//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Neil Houselander on 08/02/2018.
//  Copyright © 2018 Neil Houselander. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem)
    
    
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func newCancel() {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func newDone() {
       
        let item = CheckListItem()
        item.text = textField.text!
        item.checked = false
        
        delegate?.addItemViewController(self, didFinishAdding: item)
        
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        
        let stringRange = Range(range, in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty {
            doneButtonOutlet.isEnabled = false
            
        } else {
            doneButtonOutlet.isEnabled = true
        }
        return true
    }

}
