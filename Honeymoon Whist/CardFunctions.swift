//
//  CardFunctions.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/4/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation

class CardFunctions {
    
    func getDistribution(hand: [Int]) -> [Int] {
        var clubCount = 0
        var diamondCount = 0
        var heartCount = 0
        var spadeCount = 0
        
        for card in hand {
            if getSuit(card) == 0 { clubCount++ }
            else if getSuit(card) == 1 { diamondCount++ }
            else if getSuit(card) == 2 { spadeCount++ }
            else { heartCount++ }
        }
        
        return [clubCount, diamondCount, spadeCount, heartCount]
    }
    
    func getLongestSuit(hand: [Int]) -> Int {
        var dist = getDistribution(hand)
        var maxLength = 0
        var longestSuit = 0
        for (index,suit) in enumerate(dist) {
            if suit > maxLength {
                longestSuit = index
                maxLength = suit
                //println(longestSuit)
            }
        }
        return longestSuit
    }
    
    func getCardsInSuit(suit: Int, hand: [Int]) -> [Int] {
        var cards = [Int]()
        for (index,card) in enumerate(hand) {
            if getSuit(card) == suit { cards.append(index) }
        }
        return cards
    }
    
    func getSuit(card: Int) -> Int {
        return card/13
    }
    
    func getValue(card: Int) -> Int {
        return card%13+2
    }
    
}