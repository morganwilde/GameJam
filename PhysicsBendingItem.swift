//
//  PhysicsBendingItem.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class PhysicsBendingItem : Item{
    

    
    var durationOfEffect:Double = 0
    var effect: Effect?

    
    init(desiredEffect:Effect) {
        super.init()
        effect = desiredEffect
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func cast(object:SKNode){
        
    }
}
