//
//  CreateViewController.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 21.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

protocol CreateTaskDelegate {
    func taskReceived(task: Task)
}


class CreateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var newTask : Task = Task()
    var delegate : CreateTaskDelegate?
    var myPickerView : UIPickerView = UIPickerView()


    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var timesADayTextField: UITextField!
    @IBOutlet weak var everyXWeeksTextField: UITextField!
    
    
    @IBOutlet var weekButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if(infoTextField.isFirstResponder) {
            guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            
            if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
                view.frame.origin.y = -keyboardRect.height
            } else {
                view.frame.origin.y = 0
            }
        }
        
    }

    //MARK:- Button actions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        newTask.title = titleTextField.text!
        newTask.info = infoTextField.text!
        
        delegate?.taskReceived(task: newTask)
        self.navigationController?.popViewController(animated: true)
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
            return 31
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
    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        if ( hospitalTextField.isFirstResponder) {
//            return pickerHospitalsData.count
//        } else {
//            return pickerData.count
//        }
//    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if ( hospitalTextField.isFirstResponder) {
//
//            return (pickerHospitalsData[row]["name"] as! String)
//        } else {
//            return pickerData[row]
//        }
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if ( _hiddenTextField.isFirstResponder) {
//            //_chiefComplaintButton.setTitle(pickerData[row], for: .normal)
//        } else if ( anticolagulant.isFirstResponder) {
//            anticolagulant.text = pickerData[row]
//        } else if (hospitalTextField.isFirstResponder) {
//            hospitalTextField.text = (pickerHospitalsData[row]["name"] as! String)
//            hospitalId = pickerHospitalsData[row]["id"] as! Int
//        } else if ( lamsScale.isFirstResponder) {
//            lamsScale.text = pickerData[row]
//        } else if ( cincinatiScaleTextField.isFirstResponder) {
//            cincinatiScaleTextField.text = pickerData[row]
//        }
    
}
    

