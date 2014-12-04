//
//  PlayViewController.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/1/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var userCardImage: UIImageView!
    @IBOutlet weak var aiCardImage: UIImageView!
    
    var userLeads = false

    var userChoice = 0
    var aiChoice = 0
    var userTricksWon = 0
    var aiTricksWon = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png")!)
        
        loadHand()
        
        playGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //sets the image views for all the cards in the hand, nil for the rest
    func loadHand() {
        var maxIndex = 0
        for (index, card) in enumerate(userHand) {
            var pic = view.viewWithTag(index+1) as UIImageView
            pic.image = UIImage(named: images[card])
            maxIndex = index
        }
        
        if userHand.count < 13 {
            for i in maxIndex+1...12 {
                var pic = view.viewWithTag(i+1) as UIImageView
                pic.image = nil
            }
        }
    }
    
    //gets aiChoice and loads hand
    func playGame() {
        
        if userLeads {
            
        } else {
            aiChoice = ai.chooseCard()
            aiCardImage.image = UIImage(named: images[aiChoice])
        }
        
        loadHand()
    }
    
    //plays a trick, called everytime a user chooses a card
    func playTrick(userCard: Int, aiCard: Int) {
        
        if userCard < userHand.count && aiCard < aiHand.count {
            var userCardIndex = userHand[userCard]
            var aiCardIndex = aiHand[aiCard]
        
            userCardImage.image = UIImage(named: images[userCardIndex])
            aiCardImage.image = UIImage(named: images[aiCardIndex])
            
            view.viewWithTag(userHand.count)?.userInteractionEnabled = false
            
            if userCardIndex > aiCardIndex {
                userLeads = true
                userTricksWon++
            } else {
                userLeads = false
                aiTricksWon++
            }
        
            userHand.removeAtIndex(userCard)
            aiHand.removeAtIndex(aiCard)
            
            playGame()
            
        }
        println(userCard, aiCard)
        println(userHand.count, aiHand.count)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //card image view taps
    @IBAction func card1Tap(sender: UITapGestureRecognizer) {
        userChoice = 1
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card2Tap(sender: UITapGestureRecognizer) {
        userChoice = 2
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card3Tap(sender: UITapGestureRecognizer) {
        userChoice = 3
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card4Tap(sender: UITapGestureRecognizer) {
        userChoice = 4
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card5Tap(sender: UITapGestureRecognizer) {
        userChoice = 5
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card6Tap(sender: UITapGestureRecognizer) {
        userChoice = 6
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card7Tap(sender: UITapGestureRecognizer) {
        userChoice = 7
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card8Tap(sender: UITapGestureRecognizer) {
        userChoice = 8
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card9Tap(sender: UITapGestureRecognizer) {
        userChoice = 9
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card10Tap(sender: UITapGestureRecognizer) {
        userChoice = 10
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card11Tap(sender: UITapGestureRecognizer) {
        userChoice = 11
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card12Tap(sender: UITapGestureRecognizer) {
        userChoice = 12
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    @IBAction func card13Tap(sender: UITapGestureRecognizer) {
        userChoice = 13
        playTrick(userChoice-1, aiCard: aiChoice)
    }
    
    
    
}




























