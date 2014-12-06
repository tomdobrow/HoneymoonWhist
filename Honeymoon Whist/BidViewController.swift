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
    var userLeads = false
    
    @IBOutlet weak var trumpSuitBar: UISegmentedControl!
    @IBOutlet weak var bidBar: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var bidButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bidBar.selectedSegmentIndex = 0
        trumpSuitBar.selectedSegmentIndex = 0
        trumpSuitBar.alpha = 0
        trumpSuitBar.userInteractionEnabled = false
        playButton.alpha = 0
        playButton.userInteractionEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png")!)
        self.view.backgroundColor = UIColor.clearColor()
        ai.hand = sorted(ai.hand)
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
    @IBAction func trumpSuitChange(sender: AnyObject) {
        
        switch trumpSuitBar.selectedSegmentIndex {
        case 0: trump = 0
        case 1: trump = 1
        case 2: trump = 2
        case 3: trump = 3
        default: trump = 0
        }
    }
    
    @IBAction func placeBid(sender: AnyObject) {
        var resultText: NSString = ""
        if (bidBar.selectedSegmentIndex != 0) {
            
            if (currentBid < bidBar.selectedSegmentIndex) {
                currentBid = bidBar.selectedSegmentIndex
                resultText = NSString(format: "%.i", bidBar.selectedSegmentIndex )
                textView.text = resultText + "\n" + textView.text

                //print("HELLO")
                bidBar.selectedSegmentIndex = ai.placeBid(currentBid)
                //print("HI")
                currentBid = bidBar.selectedSegmentIndex
                
                if currentBid == 0 {
                    userLeads = true
                    endBidding(userLeads)
                }
            
                resultText = NSString(format: "%.i", currentBid)
                textView.text = resultText + "\n" + textView.text
                //print("SUP")
            }
            else {
                print("TOO LOW")
                resultText = "Must bid higher or pass"
                textView.text = resultText + "\n" + textView.text
            }
                    }
        else {
            endBidding(userLeads)
        }
    }
    
    func trumpString() -> String {
        if trump == 0 { return "clubs" }
        else if trump == 1 { return "diamonds" }
        else if trump == 3 { return "hearts" }
        else { return "spades" }
    }
    
    func endBidding(userLeads: Bool) {
        var resultText = ""
        resultText = "Pass"
        textView.text = "\n" + resultText + "\n" + textView.text
        
        if userLeads {
            trumpSuitBar.alpha = 1.0
            trumpSuitBar.userInteractionEnabled = true
            bidBar.alpha = 0
            bidBar.userInteractionEnabled = false
            playButton.alpha = 1
            playButton.userInteractionEnabled = true
            bidButton.alpha = 0
            bidButton.userInteractionEnabled = false
            
        } else {
            trump = ai.chooseTrump()
            resultText = "Alright. Trump will be \(trumpString())"
            textView.text = resultText + "\n" + textView.text

            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 3))
            dispatch_after(delayTime, dispatch_get_main_queue()){
                
                //prepare for segue to gameplay. pass the right player and the trump
                self.performSegueWithIdentifier("startPlaying", sender: nil)
            }
        }
    }
    
    @IBAction func playButtonTap(sender: AnyObject) {
        performSegueWithIdentifier("startPlaying", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startPlaying" {
            let controller = segue.destinationViewController as PlayViewController
            controller.userLeads = userLeads
            controller.userIsOffense = userLeads
            controller.bid = currentBid
        }
    }
}



















