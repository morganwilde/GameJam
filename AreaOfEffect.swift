//
//  AreaOfEffect.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

//An object representing the are in which objects are to be affected
class AreaOfEffect: SKSpriteNode{
    
    var effect: Effect?
    
    
    init(effect:Effect){
        super.init(texture: nil, color: SKColor.greenColor(), size: CGSize(width: 400, height: 400))
        
        physicsBody = SKPhysicsBody(circleOfRadius: 200)
        
        physicsBody?.restitution = 0
        physicsBody?.dynamic = true
        physicsBody?.affectedByGravity = false
        
        physicsBody?.categoryBitMask = Mask.EFFECT
        physicsBody?.contactTestBitMask = Mask.ITEM | Mask.HERO | Mask.OBSTACLE | Mask.UTILITY
        
        alpha = 0.3
        
    }
    
    
    
    func applyTo(target:SKNode){
        effect?.applyEffect(target)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
