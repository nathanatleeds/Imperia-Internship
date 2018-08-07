//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by slaviyana chervenkondeva on 1.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var ballNum: Int = 1;
    
    @IBOutlet weak var ballImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateBall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askBall(_ sender: UIButton) {
        updateBall()
    }
    
    func updateBall() {
        ballNum = Int(arc4random_uniform(5) + 1)
        
        ballImageView.image = UIImage(named: "ball\(ballNum)")
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateBall()
    }
    
}

