//
//  RulesViewController.swift
//  Honeymoon Whist
//
//  Created by Tom Dobrow on 12/1/14.
//  Copyright (c) 2014 Tom. All rights reserved.
//

import Foundation

import UIKit

class RulesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "titlepage.png")!)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //------------right  swipe gestures in view--------------//
        //------------right  swipe gestures in view--------------//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("rightSwiped"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        //-----------left swipe gestures in view--------------//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("leftSwiped"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        //-----------down swipe gestures in view--------------//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        //-----------up swipe gestures in view--------------//
        let swipeUp = UISwipeGestureRecognizer(target: self, action: Selector("upSwiped"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    //MARK: swipe gestures
    func rightSwiped()
    {
        //println("right swiped ")
    }
    
    func leftSwiped()
    {
        //println("left swiped ")
    }
    
    func downSwiped()
    {
        //println("down swiped ")
    }
    
    func upSwiped()
    {
        //println("Up swiped ")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}