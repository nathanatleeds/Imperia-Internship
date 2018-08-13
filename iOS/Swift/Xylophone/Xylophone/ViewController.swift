//
//  ViewController.swift
//  Xylophone
//
//  Created by slaviyana chervenkondeva on 1.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer : AVAudioPlayer!
    var soundNum : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        soundNum = sender.tag
        
        playSound()
    }
    
    func playSound() {
        let soundURL = Bundle.main.url(forResource: "note\(soundNum)", withExtension: "wav")
        
        print("note\(soundNum)")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
}

