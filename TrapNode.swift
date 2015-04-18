//
//  TrapNode.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/18/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

class TrapNode : Obstacle {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: UIColor, size: CGSize, position: CGPoint) {
        super.init(texture: SKTexture(imageNamed: "ground.png"), color: color, size: size)
        userInteractionEnabled = true
        
        self.position = position
        let body = SKPhysicsBody(rectangleOfSize: size)
        body.dynamic = false
        body.categoryBitMask = Mask.OBSTACLE
        body.collisionBitMask = Mask.HERO
        body.contactTestBitMask = Mask.HERO
        body.allowsRotation = false
        self.physicsBody = body
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let scene = scene as? GameScene2 {
            if (scene.heroNode.activatedItem != nil) {
                scene.heroNode.activatedItem!.cast(self)
            }
        }
    }
    
}