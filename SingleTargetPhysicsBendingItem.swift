//
//  SingleTargetPhysicsBendingItem.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//



import SpriteKit


class SingleTargetPhysicsBendingItem: PhysicsBendingItem {
    
    override init(desiredEffect:Effect) {
        super.init(desiredEffect: desiredEffect)
        durationOfEffect = 5
        name = "Single target physics bending item"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cast(target:SKNode) {
        effect?.applyEffect(target)
    }
    
}
