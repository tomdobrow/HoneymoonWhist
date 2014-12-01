//
//  WhistPlayer.swift
//  Honeymoon Whist
//
//  Created by Jack Reuter on 12/1/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation

class WhistPlayer {
    
    func chooseCard() -> Int {
        return Int(arc4random_uniform(13))
    }
    
}