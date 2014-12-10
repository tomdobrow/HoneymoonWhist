//
//  HomeViewController.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/5/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit
import AVFoundation

//var audioPlayer = AVAudioPlayer()
//var audioPlayer2 = AVAudioPlayer()

class HomeViewController: UIViewController {

    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        let soundURL = NSBundle.mainBundle().URLForResource("AppMusic", withExtension: "mp3")
        soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        soundPlayer.play()
        
//        let soundURL2 = NSBundle.mainBundle().URLForResource("Fleetwood Mac - Go Your Own Way (HQ)", withExtension: "mp3")
//        audioPlayer2 = AVAudioPlayer(contentsOfURL: soundURL2, error: nil)
//        audioPlayer2.play()
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playGame" {
            soundPlayer.stop()
        }
    }

}
