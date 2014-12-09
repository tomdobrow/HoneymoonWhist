//
//  RulesOverviewController.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/9/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation

class RulesOverviewController: RulesViewController {
    
    override func leftSwiped() {
        self.performSegueWithIdentifier("overviewToSetting", sender: nil)
    }
    
    override func downSwiped() {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

}