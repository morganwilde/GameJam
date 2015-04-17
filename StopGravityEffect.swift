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
        target.runAction(SKAction.runBlock({
            target.physicsBody?.affectedByGravity = false
            target.physicsBody?.velocity = CGVector.zeroVector
            
            SKAction.waitForDuration(self.durationOfEffect as NSTimeInterval)
            
            target.physicsBody?.affectedByGravity = true
        }))
    }
    
}
