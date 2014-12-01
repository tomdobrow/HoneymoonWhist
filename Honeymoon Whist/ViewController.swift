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
    
    
    var cardArray = [UIImageView]()
    
    var cardNumber: Int = 0
    var activeCards: Int = 0
    
    var images = [String]()
    var deck = [Int]()
    
    var yourCards = [Int]()
    
    override func viewDidLoad() {
        setUpDeck()
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpDeck () {
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
        //cardArray[0] = card1Image
        //var images = [String]()
        images = ["2c","2d","2h","2s","3c","3d","3h","3s","4c","4d","4h","4s","5c","5d","5h","5s","6c","6d","6h","6s","7c","7d","7h","7s","8c","8d","8h","8s","9c","9d","9h","9s","10c","10d","10h","10s","jc","jd","jh","js","qc","qd","qh","qs","kc","kd","kh","ks","ac","ad","ah","as"]
        
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
        activeCards += 1
        if (cardNumber <= 51) {
            
            card1Image.image = UIImage(named: images[deck[cardNumber]])
            card2Image.image = UIImage(named: images[deck[cardNumber]])
            card3Image.image = UIImage(named: images[deck[cardNumber]])
            card4Image.image = UIImage(named: images[deck[cardNumber]])
            card5Image.image = UIImage(named: images[deck[cardNumber]])
            card6Image.image = UIImage(named: images[deck[cardNumber]])
            card7Image.image = UIImage(named: images[deck[cardNumber]])
            card8Image.image = UIImage(named: images[deck[cardNumber]])
            card9Image.image = UIImage(named: images[deck[cardNumber]])
            card10Image.image = UIImage(named: images[deck[cardNumber]])
            card11Image.image = UIImage(named: images[deck[cardNumber]])
            card12Image.image = UIImage(named: images[deck[cardNumber]])
            card13Image.image = UIImage(named: images[deck[cardNumber]])
            

        }
        cardNumber += 1
        if (cardNumber >= 52) {
            deckImage.image = nil
            
        }
        else {
            deckImage.image = UIImage(named: images[deck[cardNumber]])
        }
        
    }
    @IBAction func discardButtonTap(sender: AnyObject) {
        //card1Image.image = UIImage(named: images[deck[2]])
        //discardImage.image = UIImage(named: "b2fv")
        cardNumber += 1
        if (cardNumber <= 51) {
            deckImage.image = UIImage(named: images[deck[cardNumber]])
        }
        else {
            deckImage.image = nil
        }
    }
    
   
    


}

