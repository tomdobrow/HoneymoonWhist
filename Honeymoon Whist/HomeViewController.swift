//
//  HomeViewController.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/5/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit
import AVFoundation

var soundPlayer = AVAudioPlayer()
//var soundPlayer2 = AVAudioPlayer()
var isMuted = false
var playbackTheme = true
var playSong = true

var bestOf = 1
var youPlayFirst = true
var yourWinCount = 0
var hisWinCount = 0


//var audioPlayer = AVAudioPlayer()
//var audioPlayer2 = AVAudioPlayer()

class HomeViewController: UIViewController {
    @IBOutlet weak var creditsButton: UIButton!
    
    @IBOutlet weak var bestOf1: UIButton!
    @IBOutlet weak var bestOf3: UIButton!
    @IBOutlet weak var bestOf5: UIButton!
    @IBOutlet weak var bestOf7: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
    func skraw() {
        if playbackTheme {
            //println("just doing some dandy debugging here.")
            soundPlayer.stop()
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        }
    }
    
    
    override func viewDidLoad() {
        
        bestOf1.hidden = true
        bestOf3.hidden = true
        bestOf5.hidden = true
        bestOf7.hidden = true
        
        if isMuted {
            let image = UIImage(named: "muteIcon")
            soundButton.setImage(image, forState: .Normal)
        }
        else {
            let image = UIImage(named: "soundIcon")
            soundButton.setImage(image, forState: .Normal)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        bestOf1.hidden = true
//        bestOf3.hidden = true
//        bestOf5.hidden = true
//        bestOf7.hidden = true

        playbackTheme = true
        
        if playSong {
            playSong = true
            let soundURL = NSBundle.mainBundle().URLForResource("AppMusic", withExtension: "mp3")
            soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
            
            if isMuted {
                let image = UIImage(named: "muteIcon")
                soundButton.setImage(image, forState: .Normal)
                soundPlayer.volume = 0.0
            }
            else {
                let image = UIImage(named: "soundIcon")
                soundButton.setImage(image, forState: .Normal)
                soundPlayer.volume = 1.0
            }
            var soundTimer: NSTimer = NSTimer()
            soundPlayer.prepareToPlay()
            soundPlayer.play()
            soundTimer = NSTimer.scheduledTimerWithTimeInterval(32, target: self, selector: Selector("skraw"), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func soundButtonTap(sender: AnyObject) {
        if isMuted {
            isMuted = false
            let image = UIImage(named: "soundIcon")
            soundButton.setImage(image, forState: .Normal)
            soundPlayer.volume = 1.0
        }
        else {
            isMuted = true
            let image = UIImage(named: "muteIcon")
            soundButton.setImage(image, forState: .Normal)
            soundPlayer.volume = 0.0
        }
    }
    @IBAction func startGameButton(sender: AnyObject) {
        playButton.setTitle("PLAY BEST OF SERIES:", forState: UIControlState.Normal)
        playButton.userInteractionEnabled = false
        view.bringSubviewToFront(playButton)
        
        creditsButton.userInteractionEnabled = false
        creditsButton.alpha = 0.3
        rulesButton.userInteractionEnabled = false
        rulesButton.alpha = 0.3
        
        UIView.animateWithDuration(0.2, delay:0.0, options:nil,
            animations: {
                self.bestOf1.hidden = false
                self.bestOf1.center.y += 50
            },
            completion: { (finished: Bool) in
                UIView.animateWithDuration(0.2, delay:0.0, options:nil,
                    animations: {
                        self.bestOf3.hidden = false
                        self.bestOf3.center.y += 100
                    },
                    completion: { (finished: Bool) in
                        UIView.animateWithDuration(0.2, delay:0.0, options:nil,
                            animations: {
                                self.bestOf5.hidden = false
                                self.bestOf5.center.y += 150
                            },
                            completion: { (finished: Bool) in
                                UIView.animateWithDuration(0.2, delay:0.0, options:nil,
                                    animations: {
                                        self.bestOf7.hidden = false
                                        self.bestOf7.center.y += 200
                                    },
                                    completion: nil)
                            })
                    })
            })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        soundPlayer.stop()
        playbackTheme = false
        
        yourWinCount = 0
        hisWinCount = 0
        if segue.identifier == "bo1" {
            bestOf = 1
        }
        if segue.identifier == "bo3" {
            bestOf = 3
        }
        if segue.identifier == "bo5" {
            bestOf = 5
        }
        if segue.identifier == "bo7" {
            bestOf = 7
        }
    }
    
}