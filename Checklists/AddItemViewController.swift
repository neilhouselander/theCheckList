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
    
    //make a property that is of the protocol type AddItemViewControllerDelegate
    weak var delegate: AddItemViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        

    }
    
    //dismiss keyboard when return is hit -> however can handle by hooking up the didEnOnExit of the textfield in storyboard to the done function below (newDone)
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        //make the keyboard pop up as soon as the view appears
        textField.becomeFirstResponder()
    }
    
    @IBAction func newCancel() {
        
        delegate?.addItemViewControllerDidCancel(self)//using protocol method
    }
    
    @IBAction func newDone() {
       
        let item = CheckListItem()
        item.text = textField.text!
        item.checked = false
        
        delegate?.addItemViewController(self, didFinishAdding: item) //using protocol method
        //so here we are calling a method that is implemented in other viewcontroller so clicking done creates an item based on text in textfield then fires didFinishAdding which adds the item to the array declared over there
    }
    
    //disable ability to select the row (just want the text field)
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    //handle empty strings
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
