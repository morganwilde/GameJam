//
//  Button.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/17/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

struct Mask {
    static let SCENE        = 0x1 << 1 as UInt32
    static let HERO         = 0x1 << 1 as UInt32
    static let UTILITY      = 0x1 << 2 as UInt32
    static let BUTTON       = 0x1 << 3 as UInt32
    static let ITEM         = 0x1 << 4 as UInt32
    static let OBSTACLE     = 0x1 << 5 as UInt32
}

class Button : Utility {
    
    struct Const {
        static let DEFAULT_WIDTH = 100 as CGFloat
        static let DEFAULT_HEIGHT = 100 as CGFloat
        static let DEFAULT_PUSH_DURATION = 0.5 as NSTimeInterval
    }
    
    let INITIAL_HEIGHT : CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        INITIAL_HEIGHT = Const.DEFAULT_HEIGHT
        super.init(texture: nil, color: SKColor.redColor(),
            size: CGSizeMake(Const.DEFAULT_WIDTH, Const.DEFAULT_HEIGHT))
        anchorPoint = CGPointMake(0, 0)
        
        // Physics
        println(frame)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsBody!.categoryBitMask = Mask.SCENE
        physicsBody!.contactTestBitMask = Mask.SCENE | Mask.HERO
        physicsBody!.collisionBitMask = Mask.SCENE | Mask.HERO
        
        push()
    }
    
    func push() {
        let pushAction = SKAction.scaleXBy(1, y: 0.4, duration: Const.DEFAULT_PUSH_DURATION)
        runAction(pushAction) {
            self.pop()
        }
    }
    
    func pop() {
        let popAction = SKAction.resizeToHeight(INITIAL_HEIGHT,
            duration: Const.DEFAULT_PUSH_DURATION)
        runAction(popAction)
    }
    
}