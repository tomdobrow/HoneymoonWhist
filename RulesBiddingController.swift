//
//  RulesBiddingController.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/9/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation

class RulesBiddingController: RulesViewController {
    
    override func rightSwiped() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func leftSwiped() {
        self.performSegueWithIdentifier("biddingToPlaying", sender: nil)
    }
    
    override func downSwiped() {
        playSong = false
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
     
}