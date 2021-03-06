//
//  LevelCompleteNode.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/18/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteNode : SKSpriteNode, Contactable {
    
    let level: Int
    
    init(texture: SKTexture, size : CGSize, level: Int) {
        self.level = level
        super.init(texture: texture, color: nil, size: size)
        
        let body = SKPhysicsBody(rectangleOfSize: size)
        body.categoryBitMask = Mask.SUCCESS
        body.collisionBitMask = Mask.HERO
        body.contactTestBitMask = Mask.HERO
        
        body.affectedByGravity = false
        
        self.physicsBody = body
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        scene?.view?.presentScene(LevelCompleteScene(size: scene!.size, level: level))
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
}
 