//
//  AddTaskViewController.swift
//  InvestigatorApp
//
//  Created by Артём on 6/11/21.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var pushIsOnSwitch: UISwitch!
    
    public var completion: ((String, String, Date, Bool) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        bodyTextField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(didTapSaveButton))
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func didTapSaveButton(){
        if let titleText = titleTextField.text, !titleText.isEmpty,
           let bodyText = bodyTextField.text, !bodyText.isEmpty{
            
            let targetDate = datePicker.date
            let pushIsOn = pushIsOnSwitch.isOn
            
            completion?(titleText, bodyText, targetDate, pushIsOn)
        }
    }
    
    
    
}

extension AddTaskViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
