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


class CreateViewController: UIViewController, UITextFieldDelegate {
    var newTask : Task = Task()
    var delegate : CreateTaskDelegate?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        infoTextField.delegate = self
        
        // Hide keyboard when tapping outside of text field
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        view.addGestureRecognizer(tap)
        
    }
    
    // Stop listening for keyboard events
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Keyboard
    
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    
    
}
