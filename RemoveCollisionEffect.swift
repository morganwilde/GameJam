//
//  RemoveCollisionEffect.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class RemoveCollisionsEffect : Effect {
    
    override func applyEffect(target: SKNode) {
        
        var oldCollsionBitMask = target.physicsBody?.collisionBitMask
        var oldContactBitMask = target.physicsBody?.contactTestBitMask
        
        target.runAction(SKAction.sequence([
            SKAction.runBlock({
                target.physicsBody?.collisionBitMask = Mask.GROUND
                target.physicsBody?.collisionBitMask = Mask.GROUND
                
                target.alpha = 0.2
            }), SKAction.waitForDuration(5),
            
            SKAction.runBlock({
                target.physicsBody?.collisionBitMask = oldCollsionBitMask!
                target.physicsBody?.contactTestBitMask = oldContactBitMask!
                
                target.alpha = 1
            })
            
            
            ]))
    }
    
}