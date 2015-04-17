//
//  StopGravityEffect.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class StopGravityEffect : Effect {
    
    override func applyEffect(target: SKNode) {
        
        let oldVelocity = target.physicsBody?.velocity
        let oldAffectedByGravity = target.physicsBody?.affectedByGravity
        
        target.runAction(SKAction.sequence([
            SKAction.runBlock({
                target.physicsBody?.affectedByGravity = false
                
                target.physicsBody?.velocity = CGVector.zeroVector
                
                target.alpha = 0.3
            }), SKAction.waitForDuration(5),
            
            SKAction.runBlock({
                target.physicsBody?.affectedByGravity = oldAffectedByGravity!
                
                target.physicsBody?.velocity = oldVelocity!
                
                target.alpha = 1
            })
            
            
            ]))
    }
    
}
