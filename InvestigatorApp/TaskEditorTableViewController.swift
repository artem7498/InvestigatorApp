//
//  TaskEditorTableViewController.swift
//  InvestigatorApp
//
//  Created by Артём on 6/14/21.
//

import UIKit
import NotificationCenter

class TaskEditorTableViewController: UITableViewController {
    
    @IBOutlet weak var saveTaskButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pushIsOnSwitch: UISwitch!
    
    public var completion: ((OwnTask) -> Void)?
    
    var toDoItem: OwnTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appActiveNotification), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        hideKeyboardOnTap()
        titleTextField.delegate = self
        
        updateUserInterface()
    }
    
    @objc func appActiveNotification(){
        print("The app just came to foreground")
        updateReminderSwitch()
    }
    
    func updateUserInterface(){
        if toDoItem != nil{
            titleTextField.text = toDoItem?.title
            bodyTextField.text = toDoItem?.body
            datePicker.date = toDoItem!.date
            pushIsOnSwitch.isOn = toDoItem!.reminderSet
        } else {
            titleTextField.becomeFirstResponder()
        }
        updateReminderSwitch()
        enableDisableSaveButton(text: titleTextField.text!)
    }
    
    func updateReminderSwitch(){
        LocalNotificationManager.isAuthorized { authorized in
            DispatchQueue.main.async {
                if !authorized && self.pushIsOnSwitch.isOn{
                    self.oneButtonAlert(title: "Push отключены", message: "Чтобы получать напоминания и уведомления о предстоящих событиях, перейдите в Настройки, выберите Ежедневник Следователя > Уведомления > Разрешить уведомления ")
                    self.pushIsOnSwitch.isOn = false
                }
            }
        }
    }
    
    @IBAction func pushIsOnSwitchChanged(_ sender: Any) {
        updateReminderSwitch()
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
           let bodyText = bodyTextField.text{
            
            let targetDate = datePicker.date
            let pushIsOn = pushIsOnSwitch.isOn
            
            if toDoItem == nil {
                toDoItem = OwnTask(title: titleText, body: bodyText, date: targetDate, reminderSet: pushIsOn)
            } else {
                toDoItem?.title = titleText
                toDoItem?.body = bodyText
                toDoItem?.date = targetDate
                toDoItem?.reminderSet = pushIsOn
            }
            
            completion?(toDoItem!)
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
