//
//  EditViewController.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 22.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

protocol EditTaskDelegate {
    func receivedEditedTask(newTask: Task)
    func receivedDeletedTask()
}


class EditViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    
    @IBOutlet weak var timesADayTextField: UITextField!
    @IBOutlet weak var everyXWeeksTextField: UITextField!
    
    @IBOutlet var weekButtons: [UIButton]!
    @IBOutlet weak var everyDayButton: UIButton!
    
    var myPickerView : UIPickerView = UIPickerView()
    
    
    var task : Task = Task()
    var delegate : EditTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = task.title
        infoTextField.text = task.info
        timesADayTextField.text = "\(task.timesADay)"
        everyXWeeksTextField.text = "\(task.everyXWeeks)"
        selectButtons()
        
        titleTextField.delegate = self
        infoTextField.delegate = self
        timesADayTextField.delegate = self
        everyXWeeksTextField.delegate = self
        
        // Hide keyboard when tapping outside of text field
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        view.addGestureRecognizer(tap)
        
        //init pickerview
        
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        self.myPickerView.isUserInteractionEnabled = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectButtons() {
        var selectEveryDay = true
        
        for key in task.weekDays.keys {
            selectEveryDay = task.weekDays[key]! && selectEveryDay
        }
        
        if(selectEveryDay) {
            everyDayButton.isSelected = true
        }
        else {
            for key in task.weekDays.keys {
                
                if(task.weekDays[key]!) {
                    let button : UIButton = view.viewWithTag(key) as! UIButton
                     button.isSelected = true
                }
               
            }
        }
    }
    

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete task", message: "Sell your task for 500 coins?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) in
            self.delegate?.receivedDeletedTask()
            self.dismiss(animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {

        task.title = titleTextField.text!
        task.info = infoTextField.text!

        task.timesADay = Int(timesADayTextField.text!)!
        task.everyXWeeks = Int(everyXWeeksTextField.text!)!
        
        if(everyDayButton.isSelected) {
            for day in task.weekDays.keys {
                task.weekDays.updateValue(true, forKey: day)
            }
        } else {
            for button in weekButtons {
                if(button.isSelected) {
                    task.weekDays.updateValue(true, forKey: button.tag)
                }
            }
        }
        
        self.delegate?.receivedEditedTask(newTask: task)
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func weekButtonPressed(_ sender: UIButton) {
        var changeSelected : Bool = true
        
        if(sender.isSelected) {
            sender.isSelected = false
            if(sender == everyDayButton) {
                weekButtons[0].isSelected = true
            }
            else {
                for button in weekButtons {
                    changeSelected = changeSelected && !button.isSelected
                }
                if(changeSelected) {
                    everyDayButton.isSelected = true
                }
            }
        }
        else {
            sender.isSelected = true
            if(sender == everyDayButton) {
                for button in weekButtons {
                    button.isSelected = false
                }
            } else {
                for button in weekButtons {
                    changeSelected = changeSelected && button.isSelected
                }
                
                if(changeSelected) {
                    everyDayButton.isSelected = true
                    for button in weekButtons {
                        button.isSelected = false
                    }
                }
                else {
                    everyDayButton.isSelected = false
                }
            }
        }
    }
    
    //MARK:- Keyboard
    
    // Stop listening for keyboard events
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        //print("Keyboard will show: \(notification.name.rawValue)")
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if(infoTextField.isFirstResponder || timesADayTextField.isFirstResponder || everyXWeeksTextField.isFirstResponder) {
            
            if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
                view.frame.origin.y = -keyboardRect.height
            }
        }
        
        if(notification.name == Notification.Name.UIKeyboardWillHide)
        {
            view.frame.origin.y = 0
        }
    }
    
    //MARK:- TextField delegate methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == timesADayTextField || textField == everyXWeeksTextField) {
            
            pickUp(textField)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    


//MARK:- PickerView delegate methods

func pickUp(_ textField : UITextField){
    
    textField.inputView = self.myPickerView
    
    if textField == timesADayTextField {
        self.myPickerView.selectRow(Int(timesADayTextField.text!)! - 1, inComponent: 0, animated: true)
    }
    else if textField == everyXWeeksTextField {
        self.myPickerView.selectRow(Int(everyXWeeksTextField.text!)! - 1, inComponent: 0, animated: true)
    }
    
    // ToolBar
    let toolBar = UIToolbar()
    toolBar.barStyle = .default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 134.0/255.0, green: 146.0/255.0, blue: 169.0/255.0, alpha: 1.0)
    toolBar.sizeToFit()
    
    // Adding Button ToolBar
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
    
    toolBar.setItems([ doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    textField.inputAccessoryView = toolBar
}

func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

@objc func doneClick() {
    if(timesADayTextField.isFirstResponder) {
        timesADayTextField.resignFirstResponder()
    } else if(everyXWeeksTextField.isFirstResponder) {
        everyXWeeksTextField.resignFirstResponder()
    }
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if ( timesADayTextField.isFirstResponder) {
        return 24
    }
    else if ( everyXWeeksTextField.isFirstResponder) {
        return 10
    }
    
    return 10
}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return "\(row + 1)"
}


func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if ( timesADayTextField.isFirstResponder) {
        timesADayTextField.text = "\(row + 1)"
    }
    else {
        everyXWeeksTextField.text = "\(row + 1)"
    }
    
}
}

