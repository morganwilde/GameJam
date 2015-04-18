//
//  Item.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Item : SKSpriteNode, Contactable{
    
    var pickedUp = false
    
    init(){
        super.init(texture: SKTexture(imageNamed: "ring.png"), color: SKColor.redColor(), size: CGSize(width: 40, height: 40))
        
        physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        physicsBody?.restitution = 0
        physicsBody?.dynamic = true
        
        userInteractionEnabled = true
        
        physicsBody?.categoryBitMask = Mask.ITEM
        physicsBody?.collisionBitMask = Mask.ITEM | Mask.GROUND | Mask.HERO | Mask.OBSTACLE | Mask.EFFECT
        physicsBody?.contactTestBitMask = Mask.ITEM | Mask.GROUND | Mask.HERO | Mask.OBSTACLE | Mask.EFFECT
        
        name = "item"
    }

    func getCollected(){
        runAction(SKAction.removeFromParent())
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {

    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    func effect(){
        
    }
    
    func cast(){

    }
    
    
}
