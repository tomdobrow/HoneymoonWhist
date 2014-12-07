//
//  CreditsViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 12/7/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation
import UIKit

class CreditsViewController: UIViewController {
    
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
        UIView.animateWithDuration(2.0, delay:0.0, options:nil, animations: {
            
            self.scrollText.center = CGPoint(x:self.scrollText.center.x, y:-100)
        }, completion: nil)
    }
    
}
