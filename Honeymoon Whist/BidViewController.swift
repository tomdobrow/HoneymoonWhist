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
    
    var highestBid = 0
    var bidValue = BidValue.Pass
    var currentBid = 0
    var userLeads = false
    
    
    @IBOutlet weak var yourBubble: UIImageView!
    @IBOutlet weak var hisBubble: UIImageView!
    @IBOutlet weak var trumpSuitBar: UISegmentedControl!
    @IBOutlet weak var bidBar: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var bidButton: UIButton!
    
    @IBOutlet weak var yourBidLabel: UILabel!
    @IBOutlet weak var hisBidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bidBar.selectedSegmentIndex = 0
        trumpSuitBar.selectedSegmentIndex = 0
        trumpSuitBar.alpha = 0
        trumpSuitBar.userInteractionEnabled = false
        playButton.alpha = 0
        playButton.userInteractionEnabled = false
        yourBubble.hidden = true
        hisBubble.hidden = true
        
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
        //var resultText: NSString = ""
        if (bidBar.selectedSegmentIndex != 0) {
            
            if (currentBid < bidBar.selectedSegmentIndex) {
                currentBid = bidBar.selectedSegmentIndex
                
                hisBubble.hidden = false
                yourBubble.hidden = false
                yourBidLabel.text = NSString(format: "%.i", bidBar.selectedSegmentIndex )
                hisBidLabel.text = "Hmm.."
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
                dispatch_after(delayTime, dispatch_get_main_queue()){
                    
                    self.highestBid = self.currentBid
                    
                    self.bidBar.selectedSegmentIndex = ai.placeBid(self.currentBid)
                    self.currentBid = self.bidBar.selectedSegmentIndex
                    
                    if self.currentBid == 0 {
                        self.userLeads = true
                        self.hisBubble.hidden = false
                        self.yourBubble.hidden = true
                        self.hisBidLabel.text = "Pass"
                        self.yourBidLabel.text = ""
                        self.yourBubble.hidden = true
                        
                        self.endBidding(self.userLeads)
                        
                    } else {
                        self.hisBubble.hidden = false
                        self.hisBidLabel.text = NSString(format: "%.i", self.bidBar.selectedSegmentIndex )
                        self.highestBid = self.currentBid
                    }
                    
                }
            }
            else {
                print("TOO LOW")
                hisBubble.hidden = false
                yourBubble.hidden = false
                hisBidLabel.text = "Too Low"
                yourBidLabel.text = "Oops.."
            }
        }
        else {
            yourBubble.hidden = false
            yourBidLabel.text = "Pass"
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
            dispatch_after(delayTime, dispatch_get_main_queue()){
                self.endBidding(self.userLeads)
            }
        }
    }
    
    func trumpString() -> String {
        if trump == 0 { return "Clubs" }
        else if trump == 1 { return "Diamonds" }
        else if trump == 2 { return "Spades" }
        else { return "Hearts" }
    }
    
    func endBidding(userLeads: Bool) {
        
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
            hisBubble.hidden = false
            hisBidLabel.text = "\(trumpString())"
            yourBidLabel.text = ""
            yourBubble.hidden = true
            //textView.text = resultText + "\n" + textView.text

            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 2))
            dispatch_after(delayTime, dispatch_get_main_queue()){
                
                //prepare for segue to gameplay. pass the right player and the trump
                self.performSegueWithIdentifier("startPlaying", sender: nil)
            }
        }
    }
    
    @IBAction func playButtonTap(sender: AnyObject) {
        hisBubble.hidden = true
        yourBubble.hidden = false
        yourBidLabel.text = "\(trumpString())"
        hisBidLabel.text = ""
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            
            //prepare for segue to gameplay. pass the right player and the trump
            self.performSegueWithIdentifier("startPlaying", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startPlaying" {
            let controller = segue.destinationViewController as PlayViewController
            controller.userLeads = userLeads
            controller.userIsOffense = userLeads
            controller.bid = highestBid
            ai.isOnOffense = !userLeads
        }
    }
}



















