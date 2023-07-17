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
    

    var player: AVAudioPlayer?
    let softEgg = 5
    let medEgg = 7
    let hardEgg = 12
    let eggTime : Dictionary<String, Int> = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    @IBOutlet weak var headerLable: UILabel!
    
    var totalTime : Int  = 0
    var secondsPassed : Int = 0
    
    var timer : Timer = Timer()
    
    var progress: Float = 1.0
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func eggPressed(_ sender: UIButton) {
        
        timer.invalidate()
        
        
        let hardness:String = sender.currentTitle ?? "null"
        print(self.eggTime[hardness]!)
        headerLable.text = hardness
        
        totalTime = eggTime[hardness]!
        progressView.progress = 0.0
        
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:  #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    
    @objc func updateTimer(){
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            
            let percentageProgress : Float = Float(secondsPassed) / Float(totalTime)
            
            progressView.progress = percentageProgress
            
        }else{
            headerLable.text = "DONE!"
            playSound()
        }
        
        
    }
    
  

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
