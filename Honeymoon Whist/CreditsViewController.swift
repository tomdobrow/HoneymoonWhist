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
    @IBOutlet weak var scrollText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png")!)
        view.bringSubviewToFront(backButton)
        scrollText.text =
        "Guy who did shit:\t\t                    Tom Dobrow \n\n\n\n\n\nGuy who didn't do shit:\t   Jack 'The Dong' Reuter"
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    func animate() {
        
        //testImage.image = UIImage(named: "10c")
        //testImage.center = CGPoint(x:100, y:100)
        UIView.animateWithDuration(10.0, delay: 0.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations:
            {
                
                self.scrollText.center.x += 300
                
            }, completion: {
                (finished: Bool) in
                //println("sup")
            })
        
    }
    
}
