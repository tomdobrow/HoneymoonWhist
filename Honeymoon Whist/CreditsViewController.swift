//
//  CreditsViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 12/7/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollTextLeft: UITextView!
    @IBOutlet weak var scrollTextRight: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollTextLeft.hidden = false
        scrollTextLeft.text = "Chief Developers:\n\nChief Designers:\n\n\nDesign Support:"
        scrollTextRight.hidden = false
        scrollTextRight.text = "Jack Reuter\nTom Dobrow\n\nTom Dobrow\nJack Reuter\n\nDaniel Sandoval\nDanny Dobrow"
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func doneButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        playSong = false
    }
    
}
