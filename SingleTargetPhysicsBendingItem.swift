//
//  SingleTargetPhysicsBendingItem.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class SingleTargetPhysicsBendingItem: PhysicsBendingItem {
    
    override init(parent: SKScene) {
        super.init(parent: parent)
        durationOfEffect = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func effect(object:SKSpriteNode) {
        
        object.runAction(SKAction.runBlock({
            object.physicsBody?.affectedByGravity = false
            object.physicsBody?.velocity = CGVector.zeroVector
            
            SKAction.waitForDuration(self.durationOfEffect as NSTimeInterval)
            
            object.physicsBody?.affectedByGravity = true
        }))
        
    }
    
    
    func cast(object:SKSpriteNode) {
        
        effect(object)
        
    }
    
}
