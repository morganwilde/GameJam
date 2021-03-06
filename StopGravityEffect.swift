//
//  StopGravityEffect.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class StopGravityEffect : Effect {
    
    override init() {
        super.init()
        name = "Gravitational hault"
    }
    
    override func applyEffect(target: SKNode) {
        
        let oldVelocity = target.physicsBody?.velocity
        let oldDynamic = target.physicsBody?.dynamic
        
        if let affectable = target as? Affectable {
            target.runAction(SKAction.sequence([
                SKAction.runBlock({
                    affectable.affected = true
                    target.physicsBody?.velocity = CGVector.zeroVector
                    target.alpha = 0.3
                }),
                SKAction.waitForDuration(5),
                SKAction.runBlock({
                    affectable.affected = false
                    target.physicsBody?.dynamic = true
                    target.physicsBody?.velocity = oldVelocity!
                    target.alpha = 1
                })
            ]))
        }
    }
    
}
