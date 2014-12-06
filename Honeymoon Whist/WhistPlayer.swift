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
    
    func keepOrDiscard(card: Int) -> Bool {
        if cf.getValue(card) > 10 { return true }
        else { return false }
    }
    
    func chooseLead() -> Int {
        return hand.count-1
    }
    
    func chooseResponseTo(userCard: Int) -> Int {
        
        var userSuit = cf.getSuit(userCard)
        var dist = cf.getDistribution(hand)
        var cardsInSuit = cf.getCardsInSuit(userSuit, hand: hand)
        
        if cardsInSuit.count > 0 {
            for card in cardsInSuit {
                if hand[card] > userCard { return card }
            }
            return cardsInSuit[0]
        }
        else {
            var trumpCards = cf.getCardsInSuit(trump, hand: hand)
            if trumpCards.count > 0 { return trumpCards[0] }
            else { return 0 }
        }
        
    }
    
    func chooseTrump() -> Int {
        var dist = cf.getDistribution(hand)
        var longestSuit = 0
        var trump = 0
        for (index, suit) in enumerate(dist) {
            if suit >= longestSuit {
                longestSuit = suit
                trump = index
            }
        }
        return trump
    }
    
    func placeBid(currentBid: Int) -> Int {

        if (currentBid >= 7) {
            return 0
        }
        
        var totalLosers = 0.0
        
        for (var suit = 0; suit<4; suit+=1) {
            
            //element/13 = suit
            //element%13 = value
            var cardsOfThisSuit = [Int]()
            for (var card=0; card<13; card+=1) {
                if ( hand[card]/13 == suit ) {
                    cardsOfThisSuit.append(hand[card])
                }
            }
            
            for element in cardsOfThisSuit{
                print("\(element) ")
            }
            println("")
            
            var outsideTopRun = 0
            var highCards = 0
            
            for (var element=0; element<=cardsOfThisSuit.count; element+=1) {
                if (hand[element] != 13*suit + element + 13 - cardsOfThisSuit.count) {
                    outsideTopRun += 1
                }
            }
            for (var element=0; element<=cardsOfThisSuit.count; element+=1) {
                if ((hand[element] == (13*suit+12)) | (hand[element] == (13*suit+11)) | (hand[element] == (13*suit+10)) | (hand[element] == (13*suit+9))  | (hand[element] == (13*suit+8))) {
                    highCards += 1
                }
            }
            if ( (5-highCards)/2 ) > outsideTopRun {
                totalLosers += Double(outsideTopRun)
            }
            else {
                totalLosers += Double(((5-highCards)/2))
            }
            
        }
        
        
        
        //print ("losers \(totalLosers)")
        var myBid = Int(7 - ceil(totalLosers)) //Book
        //print("bid \(myBid)")
        if (myBid <= currentBid) {
            return 0
        } else { return myBid }
   }
}