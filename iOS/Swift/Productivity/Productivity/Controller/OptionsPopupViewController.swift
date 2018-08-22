//
//  OptionsPopupViewController.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 22.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

protocol OptionsPopupDelegate {
    func optionsChanged(action: String)
}


class OptionsPopupViewController: UIViewController {
    
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
            delegate?.optionsChanged(action: "undo")
            dismiss(animated: true)
        } else {
            print("You can't do that.")
        }
        
        
    }
    

    @IBAction func editPressed(_ sender: UIButton) {
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }


}
