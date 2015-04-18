//
//  Wall.swift
//  GameJam
//
//  Created by Henrikas Jasiūnas on 4/17/15.
//  Copyright (c) 2015 Henrikas Jasiūnas. All rights reserved.
//

import Foundation
import SpriteKit

class Wall : Obstacle {
    
    let body : SKPhysicsBody
    let defaultWidth = 20
    let defaultHeight = 100
    var isRaised = false
    
    var isBeingRisen = false
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        body = SKPhysicsBody(rectangleOfSize: CGSize(width: defaultWidth, height: defaultHeight))
        
        super.init(texture: nil, color: color, size: size)
        //super.init(texture: nil, color: SKColor.whiteColor(), size: CGSizeMake(defaultWidth, height: defaultHeight))
        
        body.affectedByGravity = false
        body.dynamic = true
        body.restitution = 0
        body.categoryBitMask = Mask.OBSTACLE
        body.collisionBitMask = Mask.HERO | Mask.GROUND
        body.contactTestBitMask = Mask.HERO | Mask.GROUND
        
        self.physicsBody = body
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func raise() {
        self.physicsBody?.affectedByGravity = false
        if !isRaised {
            self.runAction(SKAction.moveBy(CGVectorMake(0, 170), duration: 1))
            isRaised = true
        }
    }
    
    func cancelRising() {
        self.removeAllActions()
        self.physicsBody?.affectedByGravity = true
    }
    
    func lower() {
        if isRaised {
            self.runAction(SKAction.moveBy(CGVectorMake(0, -170), duration: 1))
            isRaised = false
        }
    }
}