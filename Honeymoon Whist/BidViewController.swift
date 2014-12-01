//
//  BidViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 11/30/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//
import UIKit

class BidViewController: UIViewController {
    
    enum BidValue {
        case Pass
        case bid1
        case bid2
        case bid3
        case bid4
        case bid5
        case bid6
        case bid7
    
    }
    var bidValue = BidValue.Pass
    var currentBid = 0
    
    @IBOutlet weak var bidBar: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png"))
        bidBar.selectedSegmentIndex = 0
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png")!)
        bidBar.selectedSegmentIndex = 0
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func bidBarChange(sender: AnyObject) {
        
        switch bidBar.selectedSegmentIndex {
        case 0: bidValue = .Pass
        case 1: bidValue = .bid1
        case 2: bidValue = .bid2
        case 3: bidValue = .bid3
        case 4: bidValue = .bid4
        case 5: bidValue = .bid5
        case 6: bidValue = .bid6
        case 7: bidValue = .bid7
        default: bidValue = .Pass
        }
        //print (bidBar.selectedSegmentIndex)
        
    }
    
    @IBAction func placeBid(sender: AnyObject) {
        var resultText: NSString = ""
        if (bidBar.selectedSegmentIndex != 0) {
            
            if (currentBid < bidBar.selectedSegmentIndex) {
                resultText = NSString(format: "%.i", bidBar.selectedSegmentIndex )
                currentBid = bidBar.selectedSegmentIndex
                print(currentBid)
            }
            else {
                print("TOO LOW")
                resultText = "Must Bid Higher"
            }
                    }
        else {
            resultText = "Pass"
            textView.text = "\n" + resultText + "\n" + textView.text
            var trumpSuit = "clubs"
            resultText = "Alright. Trump will be \(trumpSuit)"
            //prepare for segue to gameplay. pass the right player and the trump
        }
        textView.text = resultText + "\n" + textView.text

    }
    
}
