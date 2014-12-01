//
//  ViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 11/30/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import UIKit

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
    
    
    var cardArray = [Int]()
    var sortedArray = [Int]()
    
    var cardNumber: Int = 0
    var activeCards: Int = 0
    
    var images = [String]()
    var deck = [Int]()
    
    var yourCards = [Int]()
    
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
        
        
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
                pic.image = nil
                UIView.animateWithDuration(1.0, delay:0.0, options:nil, animations: {
                    pic.center = CGPoint(x:200, y:200)
                    }, completion:nil)
                for (var l=0; l<100000000; l++) {}
                pic.image = UIImage(named: images[deck[cardNumber]])
                
                cardArray.append(deck[cardNumber])
            }
            cardNumber += 2
            deckImage.image = UIImage(named: images[deck[cardNumber]])
            botsTurn()
        }
        else {
            deckImage.image = nil
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        sortHand()
        
    }
    @IBAction func discardButtonTap(sender: AnyObject) {
        //card1Image.image = UIImage(named: images[deck[2]])
        //discardImage.image = UIImage(named: "b2fv")
        if (cardNumber < 50) {
            cardNumber += 1
            if activeCards < 13 {
                activeCards += 1
                var pic = view.viewWithTag(activeCards) as UIImageView
                pic.image = UIImage(named: images[deck[cardNumber]])
                cardArray.append(deck[cardNumber])
            }
            cardNumber += 1
            deckImage.image = UIImage(named: images[deck[cardNumber]])
            botsTurn()
        }
        else {
            deckImage.image = nil
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
        sortHand()
        
    }
    
    func botsTurn() {
        if (cardNumber < 50) {
            cardNumber += 2
            deckImage.image = UIImage(named: images[deck[cardNumber]])
        }
        else {
            deckImage.image = nil
            self.performSegueWithIdentifier("startBidding", sender: nil)
        }
    }
    
    func sortHand() {
        sortedArray = sorted(cardArray)
        for (var i=0; i<sortedArray.count; i+=1) {
            var pic = view.viewWithTag(i+1) as UIImageView
            pic.image = UIImage(named: images[sortedArray[i]])
        }
        
    }
    
   
    


}

