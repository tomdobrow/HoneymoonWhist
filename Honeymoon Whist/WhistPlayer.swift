//
//  WhistPlayer.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/1/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation


class WhistPlayer {

    var hand = [Int]() //MAKE SURE IT"S SORTED
    
    func keepOrDiscard() -> Bool {
        return true
    }
    
    func chooseCard() -> Int {
        return 0
    }
    
    func placeBid(currentBid: Int) -> Int {
        if (currentBid >= 7) {
            return 0
        }
        var myBid = 13
        
        for (var suit = 0; suit<4; suit+=1) {
            
            //element/13 = suit
            //element%13 = value
            var cardsOfThisSuit = [Int]()
            for (var card=0; card<=13; card+=1) {
                if ( hand[card]/13 == suit ) {
                    cardsOfThisSuit.append(hand[card])
                }
            }
            for (var element=0; element<=cardsOfThisSuit.count; element+=1) {
                if ()
                
                
            }
                
                
        }
            
        
        
        
        myBid -= 6 //Book
        
        if (myBid <= currentBid) {
            return 0
        } else { return myBid }
    }
    
}