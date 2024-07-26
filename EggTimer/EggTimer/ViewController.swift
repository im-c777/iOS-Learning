//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    var player: AVAudioPlayer?
    var eggTimer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var appTitle: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        eggTimer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressView.progress = 0.0
        secondsPassed = 0
        appTitle.text = hardness
        eggTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            
        }else{
            eggTimer.invalidate()
            appTitle.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
}
