//
//  PlayViewController.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/1/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

import AVFoundation
var soundURL = NSBundle.mainBundle().URLForResource("winTrick", withExtension: "mp3")

class PlayViewController: UIViewController {
    
    @IBOutlet weak var card1Image: UIImageView!
    @IBOutlet weak var card2Image: UIImageView!
    @IBOutlet weak var card3Image: UIImageView!
    @IBOutlet weak var card4Image: UIImageView!
    @IBOutlet weak var card5Image: UIImageView!
    @IBOutlet weak var card6Image: UIImageView!
    @IBOutlet weak var card7Image: UIImageView!
    @IBOutlet weak var card8Image: UIImageView!
    @IBOutlet weak var card9Image: UIImageView!
    @IBOutlet weak var card10Image: UIImageView!
    @IBOutlet weak var card11Image: UIImageView!
    @IBOutlet weak var card12Image: UIImageView!
    @IBOutlet weak var card13Image: UIImageView!
    
    @IBOutlet weak var cardsOnTable: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var userCardImage: UIImageView!
    @IBOutlet weak var aiCardImage: UIImageView!
    @IBOutlet weak var userTricksImage: UIImageView!
    @IBOutlet weak var aiTricksImage: UIImageView!
    @IBOutlet weak var userTricksLabel: UILabel!
    @IBOutlet weak var aiTricksLabel: UILabel!
    
    @IBOutlet weak var ttImageView: UIImageView!
    @IBOutlet weak var trashTalkLabel: UILabel!
    @IBOutlet weak var runItBackLabel: UIButton!
    
    var userLeads = false
    var userIsOffense = false
    var bid = Int()
    
    var userChoice = 0
    var aiChoice = 0
    var userTricksWon = 0
    var aiTricksWon = 0
    
    var handImageCenterY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ttImageView.hidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        userTricksImage.image = UIImage(named: "b2fv")
        aiTricksImage.image = UIImage(named: "b2fv")
        
        var cardImage = view.viewWithTag(1) as UIImageView
        handImageCenterY = cardImage.center.y
        
        var t = CATransform3DIdentity
        //Add the perspective!!!
        t.m34 = 1.0 / -500.0
        t = CATransform3DRotate(t, 45.0 * CGFloat(M_PI) / 180.0, 1, 0, 0)
        
        cardsOnTable.layer.transform = t

        runItBackLabel.hidden = true
        //defaultVariables()
        loadHand()
        nextTrick()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func defaultVariables() {
        ai.hand.append(0)
        userHand.append(0)

        for i in 0...51 {
            deck.append(i)
            if cf.getValue(i) > 11 {
                ai.hand.append(i)
                userHand.append(i)
            }
        }

        images = ["2c","3c","4c","5c","6c","7c","8c","9c","10c","jc","qc","kc","ac","2d","3d","4d","5d","6d","7d","8d","9d","10d","jd","qd","kd","ad","2s","3s","4s","5s","6s","7s","8s","9s","10s","js","qs","ks","as","2h","3h","4h","5h","6h","7h","8h","9h","10h","jh","qh","kh","ah"]
    }

    //sets the image views for all the cards in the hand, nil for the rest
    func loadHand() {
        
        for i in 1...13 {
            var pic = view.viewWithTag(i) as UIImageView
            if pic.userInteractionEnabled {
                pic.image = UIImage(named: images[userHand[i-1]])
            } else {
                pic.image = nil
            }
        }
    }
    
    func disableInteraction() {
        for i in 1...userHand.count {
            var pic = view.viewWithTag(i) as UIImageView
            pic.userInteractionEnabled = false
        }
    }
    
    func enableInteraction() {
        for i in 1...userHand.count {
            var pic = view.viewWithTag(i) as UIImageView
            pic.userInteractionEnabled = true
        }
    }
    
    //gets aiChoice and loads hand
    func nextTrick() {
        disableInteraction()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            
            if self.userLeads {
                self.aiCardImage.image = nil
                self.userCardImage.image = nil
                
            } else {
                self.aiChoice = ai.chooseLead()
                if ai.hand.count > 0 { self.aiCardImage.image = UIImage(named: images[ai.hand[self.aiChoice]]) }
                self.userCardImage.image = nil
            }
            
            self.enableInteraction()
        }
    }

    func userWins(userCard: Int, aiCard: Int) -> Bool {
        
        let userSuit = cf.getSuit(userCard)
        let aiSuit = cf.getSuit(aiCard)
        
        if userSuit == aiSuit {
            if userCard > aiCard {
                if isMuted == false {
                    soundURL = NSBundle.mainBundle().URLForResource("winTrick", withExtension: "mp3")
                    soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                    soundPlayer.play()
                }
                return true
            }
            else {
                ttImageView.hidden = false
                view.bringSubviewToFront(trashTalkLabel)
                trashTalkLabel.text = "Pathetic!"
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
                dispatch_after(delayTime, dispatch_get_main_queue()){
                    self.trashTalkLabel.text = ""
                    self.ttImageView.hidden = true
                }
                if isMuted == false {
                    soundURL = NSBundle.mainBundle().URLForResource("robotNoise", withExtension: "mp3")
                    soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                    soundPlayer.play()
                }
                return false
            }
            
        } else {
            if userSuit == trump {
                if isMuted == false {
                    soundURL = NSBundle.mainBundle().URLForResource("winTrick", withExtension: "mp3")
                    soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                    soundPlayer.play()
                }
                return true
            }
            else if aiSuit == trump {
                ttImageView.hidden = false
                view.bringSubviewToFront(trashTalkLabel)
                trashTalkLabel.text = "Ouch!"
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
                dispatch_after(delayTime, dispatch_get_main_queue()){
                    self.trashTalkLabel.text = ""
                    self.ttImageView.hidden = true
                }
                if isMuted == false {
                    soundURL = NSBundle.mainBundle().URLForResource("robotNoise", withExtension: "mp3")
                    soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                    soundPlayer.play()
                }
                return false
            }
            else {
                if userLeads {
                    if isMuted == false {
                        soundURL = NSBundle.mainBundle().URLForResource("winTrick", withExtension: "mp3")
                        soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                        soundPlayer.play()
                    }
                    return true
                }
                else {
                    ttImageView.hidden = false
                    view.bringSubviewToFront(trashTalkLabel)
                    trashTalkLabel.text = "You Suck!"
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
                    dispatch_after(delayTime, dispatch_get_main_queue()){
                        self.trashTalkLabel.text = ""
                        self.ttImageView.hidden = true
                    }
                    if isMuted == false {
                        soundURL = NSBundle.mainBundle().URLForResource("robotNoise", withExtension: "mp3")
                        soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                        soundPlayer.play()
                    }
                    return false
                }
            }
        }
    }
    
    func playIsValid(userCard: Int, aiCard: Int) -> Bool {
        
        var userDist = cf.getDistribution(userHand)
        var aiDist = cf.getDistribution(ai.hand)
        var userSuit = cf.getSuit(userHand[userCard])
        var aiSuit = cf.getSuit(ai.hand[aiCard])
        
        if userSuit == aiSuit {
            return true
            
        } else {
            
            if userLeads {
                return true
                
            } else {
                if userDist[aiSuit] == 0 { return true }
                else { return false }
                
            }
        }
    }
    
    //plays a trick, called everytime a user chooses a card
    func playTrick(userCard: Int, aiCard: Int) {
        
        var userCardIndex = userHand[userCard]
        var aiCardIndex = ai.hand[aiCard]
        
        userCardImage.image = UIImage(named: images[userCardIndex])
        aiCardImage.image = UIImage(named: images[aiCardIndex])
        
        //check if user is void in trump
        if !userLeads && cf.getSuit(aiCardIndex) == trump && cf.getSuit(userCardIndex) != trump {
            ai.opponentIsVoidInTrump = true
        }
        
        view.viewWithTag(userHand.count)?.userInteractionEnabled = false
        
        if userWins(userCardIndex, aiCard: aiCardIndex) {
            userLeads = true
            userTricksWon++
            userTricksLabel.text = String(userTricksWon)
            
        } else {
            userLeads = false
            aiTricksWon++
            aiTricksLabel.text = String(aiTricksWon)
        }
        
        userHand.removeAtIndex(userCard)
        ai.hand.removeAtIndex(aiCard)
        
        loadHand()
        //println("shiiit")
        if userHand.count > 0 && ai.hand.count > 0 { nextTrick() }
        else {
            println("GAMEOVER")
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 2))
            dispatch_after(delayTime, dispatch_get_main_queue()){
                self.userCardImage.image = nil
                self.aiCardImage.image = nil
                self.userTricksImage.image = nil
                self.aiTricksImage.image = nil
                self.userTricksLabel.text = ""
                self.aiTricksLabel.text = ""
                self.runItBackLabel.hidden = false
                
            }
            
            
            if (userIsOffense && (userTricksWon >= bid+6)) || (!userIsOffense && (aiTricksWon < bid+6)) {
                if isMuted == false {
                    soundURL = NSBundle.mainBundle().URLForResource("winGame", withExtension: "mp3")
                    soundPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
                    soundPlayer.play()
                }
                println("YOU WIN")
            } else {
                println("YOU LOSE")
            }
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "runItBack" {
            
            playSong = true
            userHand = []
            deck = []
            ai.hand = []
            if youPlayFirst {
                youPlayFirst = false
            }
            else {
                youPlayFirst = true
            }
        }
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    var tapCount = 0
    var lastTapped = 0
    
    
    func respondToCardTap() {

        if !userLeads && playIsValid(userChoice, aiCard: aiChoice) || userLeads {
            var picTapped = view.viewWithTag(userChoice+1) as UIImageView
            if picTapped.center.y >= handImageCenterY {
                
                for i in 1...13 {
                    var pic = view.viewWithTag(i) as UIImageView
                    UIView.animateWithDuration(0.3, delay: 0.0, options: nil, animations: {
                        pic.center.y = self.handImageCenterY
                        }, completion: nil)
                }
                
                UIView.animateWithDuration(0.3, delay: 0.0, options: nil, animations: {
                    picTapped.center.y = self.handImageCenterY - 40
                }, completion: nil)
                
            } else {
                
                if userLeads { aiChoice = ai.chooseResponseTo(userHand[userChoice]) }
                playTrick(userChoice, aiCard: aiChoice)
                picTapped.center.y = handImageCenterY
                
            }
        }
    }
    
    @IBAction func playAgainButton(sender: UIButton) {
        self.performSegueWithIdentifier("runItBack", sender: nil)
    }
    
    //card image view taps
    @IBAction func card1Tap(sender: UITapGestureRecognizer) {
        userChoice = 0
        respondToCardTap()
    }
    @IBAction func card2Tap(sender: UITapGestureRecognizer) {
        userChoice = 1
        respondToCardTap()
    }
    @IBAction func card3Tap(sender: UITapGestureRecognizer) {
        userChoice = 2
        respondToCardTap()
    }
    @IBAction func card4Tap(sender: UITapGestureRecognizer) {
        userChoice = 3
        respondToCardTap()
    }
    @IBAction func card5Tap(sender: UITapGestureRecognizer) {
        userChoice = 4
        respondToCardTap()
    }
    @IBAction func card6Tap(sender: UITapGestureRecognizer) {
        userChoice = 5
        respondToCardTap()
    }
    @IBAction func card7Tap(sender: UITapGestureRecognizer) {
        userChoice = 6
        respondToCardTap()
    }
    @IBAction func card8Tap(sender: UITapGestureRecognizer) {
        userChoice = 7
        respondToCardTap()
    }
    @IBAction func card9Tap(sender: UITapGestureRecognizer) {
        userChoice = 8
        respondToCardTap()
    }
    @IBAction func card10Tap(sender: UITapGestureRecognizer) {
        userChoice = 9
        respondToCardTap()
    }
    @IBAction func card11Tap(sender: UITapGestureRecognizer) {
        userChoice = 10
        respondToCardTap()
    }
    @IBAction func card12Tap(sender: UITapGestureRecognizer) {
        userChoice = 11
        respondToCardTap()
    }
    @IBAction func card13Tap(sender: UITapGestureRecognizer) {
        userChoice = 12
        respondToCardTap()
    }
}
