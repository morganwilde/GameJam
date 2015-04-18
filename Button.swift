//
//  Button.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/17/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

class Button : Utility {
    
    struct Const {
        static let DEFAULT_WIDTH = 50 as CGFloat
        static let DEFAULT_HEIGHT = 8 as CGFloat
        static let DEFAULT_PUSH_DURATION = 0.5 as NSTimeInterval
    }
    
    let INITIAL_HEIGHT : CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        INITIAL_HEIGHT = Const.DEFAULT_HEIGHT
        super.init(texture: nil, color: UIColor(red: 189/255.0, green: 64/255.0, blue: 64/255.0, alpha: 255),
            size: CGSizeMake(Const.DEFAULT_WIDTH, Const.DEFAULT_HEIGHT))
        anchorPoint = CGPointMake(0, 0)
        
        // Physics
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsBody!.dynamic = false
        physicsBody!.categoryBitMask = Mask.UTILITY
        physicsBody!.contactTestBitMask = Mask.HERO
        physicsBody!.collisionBitMask = Mask.HERO
    }
    
    func push() {
        let pushAction = SKAction.scaleXBy(1, y: 0.4, duration: Const.DEFAULT_PUSH_DURATION)
        runAction(pushAction) {
            self.pop()
        }
    }
    
    func pop() {
        let popAction = SKAction.resizeToHeight(INITIAL_HEIGHT, duration: Const.DEFAULT_PUSH_DURATION)
        runAction(popAction)
    }
    
}