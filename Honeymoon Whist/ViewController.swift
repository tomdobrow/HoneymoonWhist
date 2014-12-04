//
//  ViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 11/30/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

var userHand = [Int]()
var aiHand = [1,2,3,4,5,6,7,8,9,10,11,12,13]
var images = [String]()
var deck = [Int]()

class ViewController: UIViewController {

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
    
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var discardImage: UIImageView!
    
    @IBOutlet weak var keepButton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!

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

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tabletop.png"))
        
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
        deckImage.image = UIImage(named: images[deck[cardNumber]])
        discardImage.image = UIImage(named: "b2fv")
            
        
    }
    @IBAction func keepButtonTap(sender: AnyObject) {

        if (cardNumber < 50) {
            
            if activeCards < 13 {
                activeCards += 1
                var pic = view.viewWithTag(activeCards) as UIImageView
                UIView.animateWithDuration(0.5, delay:0.0, options:nil, animations: {
                    var picBound = self.deckImage.bounds
                    var x = picBound.width
                    pic.bounds = picBound//CGPoint(x:-100, y:800)
                    pic.center = CGPoint(x: self.deckImage.center.x, y: self.deckImage.center.y)
                    }, completion:nil)
                pic.image = UIImage(named: images[deck[cardNumber]])
                
                userHand.append(deck[cardNumber])
            }
            cardNumber += 2
            deckImage.image = UIImage(named: images[deck[cardNumber]])
            botsTurn()
        }
        else {
            deckImage.image = nil
            sortHand()
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        
    }
    @IBAction func discardButtonTap(sender: AnyObject) {
        //card1Image.image = UIImage(named: images[deck[2]])
        //discardImage.image = UIImage(named: "b2fv")
        if (cardNumber < 50) {
            cardNumber += 1
            if activeCards < 13 {
                activeCards += 1
                var pic = view.viewWithTag(activeCards) as UIImageView
                UIView.animateWithDuration(0.5, delay:0.0, options:nil, animations: {
                    pic.center = CGPoint(x:0, y:0)
                    }, completion:nil)
                pic.image = UIImage(named: images[deck[cardNumber]])
                userHand.append(deck[cardNumber])
            }
            cardNumber += 1
            deckImage.image = UIImage(named: images[deck[cardNumber]])
            botsTurn()
        }
        else {
            deckImage.image = nil
            sortHand()
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        
    }
    
    func botsTurn() {
        if (cardNumber < 50) {
            cardNumber += 2
            deckImage.image = UIImage(named: images[deck[cardNumber]])
        }
        else {
            deckImage.image = nil
            sortHand()
            self.performSegueWithIdentifier("startBidding", sender: nil)
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
            UIView.animateWithDuration(1.0, delay:0.0, options:nil, animations: {
                pic.center = center
                }, completion:nil)
            pic.image = UIImage(named: images[userHand[i]])
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "startBidding" {
            keepButton.setTitle(nil, forState: nil)
            discardButton.setTitle(nil, forState: nil)
            sortButton.setTitle(nil, forState: nil)
        }
        
    }
   
    


}

