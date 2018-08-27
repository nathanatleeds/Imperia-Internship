//
//  OptionsPopupViewController.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 22.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

protocol OptionsPopupDelegate {
    func optionsChanged(action: String, task: Task)
}


class OptionsPopupViewController: UIViewController, EditTaskDelegate
{
    
    var task : Task = Task()
    var delegate : OptionsPopupDelegate?
    var index : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func undoPressed(_ sender: UIButton) {
        if(task.started) {
            
            if(task.completed) {
                let alert = UIAlertController(title: "Undo action", message: "You will lose 100 experience and 500 coins.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    (alert: UIAlertAction!) in
                    self.delegate?.optionsChanged(action: "undo", task: self.task)
                    self.dismiss(animated: true)
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                self.delegate?.optionsChanged(action: "undo", task: task)
                self.dismiss(animated: true)
            }

        } else {
            print("You can't do that.")
        }
    }
    

    @IBAction func editPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showEditMode", sender: self)
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK:- Edit task delegate methods
    
    func receivedEditedTask(newTask: Task) {
        task = newTask
        print (newTask.title)
        print (task.title)
        
        self.delegate?.optionsChanged(action: "edit", task: task)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func receivedDeletedTask() {
        self.delegate?.optionsChanged(action: "delete", task: task)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue,  sender: Any?) {
        if segue.identifier == "showEditMode" {
            let editVC = segue.destination as! EditViewController
            editVC.delegate = self
            editVC.task = task
        }

    }


}
