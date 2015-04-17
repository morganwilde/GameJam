//
//  Item.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Item : SKSpriteNode{
    
    var home: SKNode?
    
    init(parent: SKNode){
        super.init(texture: nil, color: SKColor.redColor(), size: CGSize(width: parent.frame.width / 10, height: parent.frame.height / 10))
        home = parent
        
        physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        physicsBody?.restitution = 0
        physicsBody?.dynamic = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func effect(){
        
    }
    
    func cast(){

    }
    
    
}
