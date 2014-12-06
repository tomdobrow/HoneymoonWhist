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
            else if getSuit(card) == 2 { heartCount++ }
            else { spadeCount++ }
        }
        
        return [clubCount, diamondCount, heartCount, spadeCount]
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