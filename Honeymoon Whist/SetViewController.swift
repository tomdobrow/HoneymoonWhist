//
//  ViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 11/30/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

var userHand = [Int]()
var images = [String]()
var deck = [Int]()
var ai = WhistPlayer()
var cf = CardFunctions()
var trump = 0
var slowAnimation = 0.0
var fastAnimation = 0.0
var dealAnimation = 0.0

class SetViewController: UIViewController {

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
 
    @IBOutlet weak var cardChoice1: UIImageView!
    @IBOutlet weak var cardChoice2: UIImageView!
    @IBOutlet weak var discardImage: UIImageView!
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var dealtCard: UIImageView!
    @IBOutlet weak var dealtCard2: UIImageView!
    
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var choice1Label: UILabel!
    @IBOutlet weak var choice2Label: UILabel!
    @IBOutlet weak var discardPileLabel: UILabel!

    var cardNumber: Int = 0
    var activeCards: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpDeck()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpDeck () {

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png")!)
        
        images = ["2c","3c","4c","5c","6c","7c","8c","9c","10c","jc","qc","kc","ac","2d","3d","4d","5d","6d","7d","8d","9d","10d","jd","qd","kd","ad","2h","3h","4h","5h","6h","7h","8h","9h","10h","jh","qh","kh","ah","2s","3s","4s","5s","6s","7s","8s","9s","10s","js","qs","ks","as"]
        
        //var deck = [Int]()
        for (var i = 0; i < 52; i+=1) {
            deck.append(i)
        }
        
        for (var j = 0; j < 51; j+=1) {
            let randomCard = j + Int(arc4random_uniform(52-j))
            var temp = deck[j]
            deck[j] = deck[randomCard]
            deck[randomCard] = temp
            //temp = deck[i]
            //deck[i] = deck[rand]
            //deck[rand] = temp
        }
        discardImage.image = UIImage(named: "b2fv")
        deckImage.image = UIImage(named: "b2fv")
        dealtCard.image = UIImage(named: "b2fv")
        dealtCard2.image = UIImage(named: "b2fv")
        var dealtCardCenter = dealtCard.center
        var dealtCardCenter2 = dealtCard2.center

        UIView.animateWithDuration(dealAnimation, delay:0.0, options:nil, animations: {
            
            self.cardChoice1.userInteractionEnabled = false
            self.cardChoice2.userInteractionEnabled = false

            self.view.bringSubviewToFront(self.dealtCard)
            self.view.bringSubviewToFront(self.dealtCard2)
            
            self.dealtCard.center = self.cardChoice1.center
            self.dealtCard2.center = self.cardChoice2.center
            //self.cardChoice2.center = self.discardImage.center
            //self.cardChoice1.bounds = CGRectMake(0, 0, pic.bounds.width, pic.bounds.height)
            }, completion: {
                (finished: Bool) in
                
                self.dealtCard.center = dealtCardCenter
                self.dealtCard2.center = dealtCardCenter2
                self.cardChoice1.image = UIImage(named: images[deck[self.cardNumber]])
                self.cardChoice2.image = UIImage(named: "b2fv")
             
                self.cardChoice1.userInteractionEnabled = true
                self.cardChoice2.userInteractionEnabled = true
                
        })
        
        
    }
    
    //user keeps card
    @IBAction func choice1ButtonTap(sender: UITapGestureRecognizer) {
        if (cardNumber < 50) {
            
            if activeCards < 13 {
                activeCards += 1
                var pic = view.viewWithTag(activeCards) as UIImageView
                var cardChoice1Center = cardChoice1.center
                var cardChoice2Center = cardChoice2.center
                var cardChoice1Bounds = cardChoice1.bounds
                
                if (cardNumber > 42) {
                    deckImage.image = nil
                }
                
                UIView.animateWithDuration(slowAnimation, delay:0.0, options:nil, animations: {
                    
                    self.cardChoice1.userInteractionEnabled = false
                    self.cardChoice2.userInteractionEnabled = false
                    
                    self.view.bringSubviewToFront(self.cardChoice1)
                    self.view.bringSubviewToFront(self.cardChoice2)
                    
                    self.cardChoice1.center = pic.center
                    self.cardChoice2.center = self.discardImage.center
                    self.cardChoice1.bounds = CGRectMake(0, 0, pic.bounds.width, pic.bounds.height)
                    
                    }, completion: {
                        (finished: Bool) in
                        
                        pic.image = UIImage(named: images[deck[self.cardNumber]])
                        userHand.append(deck[self.cardNumber])
                        self.cardNumber += 2
                        
                        self.cardChoice1.image = nil
                        self.cardChoice2.image = nil
                        
                        self.cardChoice1.center = cardChoice1Center
                        self.cardChoice2.center = cardChoice2Center
                        self.cardChoice1.bounds = cardChoice1Bounds

                        var dealtCardCenter = self.dealtCard.center
                        var dealtCardCenter2 = self.dealtCard2.center
                        
                        UIView.animateWithDuration(fastAnimation, delay:0.0, options:nil, animations: {
                        
                            if (self.cardNumber < 50) {
                                self.view.bringSubviewToFront(self.dealtCard)
                                self.view.bringSubviewToFront(self.dealtCard2)
                                
                                self.dealtCard.center = self.cardChoice1.center
                                self.dealtCard2.center = self.cardChoice2.center
                            }
                        
                            }, completion: {
                                (finished: Bool) in
                            
                                if (self.cardNumber >= 44) {
                                    self.dealtCard.image = nil
                                    self.dealtCard2.image = nil
                                }
                                self.dealtCard.center = dealtCardCenter
                                self.dealtCard2.center = dealtCardCenter2
                                
                                self.cardChoice2.image = UIImage(named: "b2fv")
                                self.cardChoice1.userInteractionEnabled = true
                                self.cardChoice2.userInteractionEnabled = true
                                self.botsTurn()
                                
                        })
                    })
            }
        }
        else {
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        
    }
    
    //user discards card
    
    @IBAction func choice2ButtonTap(sender: UITapGestureRecognizer) {
        if (cardNumber < 50) {
            cardNumber += 1
            if activeCards < 13 {
                activeCards += 1
                var pic = view.viewWithTag(activeCards) as UIImageView
                var cardChoice1Center = cardChoice1.center
                var cardChoice2Center = cardChoice2.center
                var cardChoice2Bounds = cardChoice2.bounds
                cardChoice1.image = UIImage(named: "b2fv")
                cardChoice2.image = UIImage(named: images[deck[self.cardNumber]])
                
                if (cardNumber > 41) {
                    deckImage.image = nil
                }
                
                UIView.animateWithDuration(slowAnimation, delay:0.0, options:nil, animations: {
                    
                    self.cardChoice1.userInteractionEnabled = false
                    self.cardChoice2.userInteractionEnabled = false
                    
                    self.view.bringSubviewToFront(self.cardChoice1)
                    self.view.bringSubviewToFront(self.cardChoice2)
                    
                    self.cardChoice1.center = self.discardImage.center
                    self.cardChoice2.center = pic.center
                    self.cardChoice2.bounds = CGRectMake(0, 0, pic.bounds.width, pic.bounds.height)
                    
                    }, completion: {
                        (finished: Bool) in
                        
                        pic.image = UIImage(named: images[deck[self.cardNumber]])
                        userHand.append(deck[self.cardNumber])
                        self.cardNumber += 1
                        
                        self.cardChoice1.image = nil
                        self.cardChoice2.image = nil
                        
                        self.cardChoice1.center = cardChoice1Center
                        self.cardChoice2.center = cardChoice2Center
                        self.cardChoice2.bounds = cardChoice2Bounds
                        
                        var dealtCardCenter = self.dealtCard.center
                        var dealtCardCenter2 = self.dealtCard2.center
                        
                        UIView.animateWithDuration(fastAnimation, delay:0.0, options:nil, animations: {
                            
                            if (self.cardNumber < 50) {
                                self.view.bringSubviewToFront(self.dealtCard)
                                self.view.bringSubviewToFront(self.dealtCard2)
                                
                                self.dealtCard.center = self.cardChoice1.center
                                self.dealtCard2.center = self.cardChoice2.center
                            }
                            
                            }, completion: {
                                (finished: Bool) in
                                
                                if (self.cardNumber >= 44) {
                                    self.dealtCard.image = nil
                                    self.dealtCard2.image = nil
                                }
                                
                                self.dealtCard.center = dealtCardCenter
                                self.dealtCard2.center = dealtCardCenter2
                                
                                self.cardChoice2.image = UIImage(named: "b2fv")
                                
                                self.cardChoice1.userInteractionEnabled = true
                                self.cardChoice2.userInteractionEnabled = true
                                self.botsTurn()
                        })
                })
            }
        }
        else {
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        
    }
    
    //bot decides
    func botsTurn() {

        //if (cardNumber <= 50) {
        if ai.keepOrDiscard(deck[cardNumber]) {
            ai.hand.append(deck[cardNumber])
        } else {
            ai.hand.append(deck[cardNumber+1])
        }
        cardNumber += 2
        
        if (cardNumber > 51) {
            cardChoice1.image = nil
            cardChoice2.image = nil
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        else {
            cardChoice1.image = UIImage(named: images[deck[cardNumber]])
        }
    }
    
    @IBAction func sortButtonTap(sender: AnyObject) {
        sortHand()
    }
    
    func sortHand() {
        userHand = sorted(userHand)
        for (var i=0; i<userHand.count; i+=1) {
            var pic = view.viewWithTag(i+1) as UIImageView
            var center = pic.center
            UIView.animateWithDuration(fastAnimation, delay:0.0, options:nil, animations: {
                pic.center = center
                }, completion:nil)
            pic.image = UIImage(named: images[userHand[i]])
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "startBidding" {
            sortHand()
            ai.hand = sorted(ai.hand)
            
            discardImage.image = nil
            deckImage.image = nil
            cardChoice1.image = nil
            cardChoice2.image = nil
            dealtCard.image = nil
            dealtCard2.image = nil
            choice1Label.text = nil
            choice2Label.text = nil
            discardPileLabel.text = nil            
            sortButton.setTitle(nil, forState: nil)
        }
        
        for card in ai.hand {
            print("\(images[card]) ")
        }
    }
}

