//
//  CreditsViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 12/7/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var scrollText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png")!)
        animate()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animate() {
        
//        UIView.animateWithDuration(4.0, options: nil, animations: {
//            
//            self.testImage.center = 0
//            
//        }, completion: nil)
        
    }
    
}
