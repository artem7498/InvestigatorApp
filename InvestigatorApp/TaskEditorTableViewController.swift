//
//  TaskEditorTableViewController.swift
//  InvestigatorApp
//
//  Created by Артём on 6/14/21.
//

import UIKit

class TaskEditorTableViewController: UITableViewController {
    
    @IBOutlet weak var saveTaskButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pushIsOnSwitch: UISwitch!
    
    public var completion: ((String, String, Date, Bool) -> Void)?
    
    var toDoItem: OwnTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()
        titleTextField.delegate = self
        
        updateUserInterface()
    }
    
    func updateUserInterface(){
        if toDoItem != nil{
            titleTextField.text = toDoItem?.title
            bodyTextField.text = toDoItem?.body
            datePicker.date = toDoItem!.date
        } else {
            titleTextField.becomeFirstResponder()
        }
        
        enableDisableSaveButton(text: titleTextField.text!)
    }
    
    func enableDisableSaveButton(text: String){
        if text.count > 0 {
            saveTaskButton.isEnabled = true
        } else {
            saveTaskButton.isEnabled = false
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let titleText = titleTextField.text, !titleText.isEmpty,
           let bodyText = bodyTextField.text, !bodyText.isEmpty{
            
            let targetDate = datePicker.date
            let pushIsOn = pushIsOnSwitch.isOn
            
            completion?(titleText, bodyText, targetDate, pushIsOn)
            
            toDoItem = nil
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        enableDisableSaveButton(text: sender.text!)
    }
    
    
    
    @IBAction func cancelButton(_ sender: Any) {
        
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func hideKeyboardOnTap(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
}

extension TaskEditorTableViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
