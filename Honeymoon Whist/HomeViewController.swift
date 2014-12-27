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



//var audioPlayer = AVAudioPlayer()
//var audioPlayer2 = AVAudioPlayer()

class HomeViewController: UIViewController {
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playGame" {
            soundPlayer.stop()
            playbackTheme = false
        }
    }
    
}