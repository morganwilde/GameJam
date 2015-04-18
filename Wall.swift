//
//  Wall.swift
//  GameJam
//
//  Created by Henrikas Jasiūnas on 4/17/15.
//  Copyright (c) 2015 Henrikas Jasiūnas. All rights reserved.
//

import Foundation
import SpriteKit

class Wall : Obstacle, Contactable {
    
    let defaultWidth = 20
    let defaultHeight = 100
    var isRaised = false
    
//    let default
    
    init(color: UIColor, size: CGSize, position: CGPoint) {
        super.init(texture: nil, color: color, size: size)
        //super.init(texture: nil, color: SKColor.whiteColor(), size: CGSizeMake(defaultWidth, height: defaultHeight))
        userInteractionEnabled = true
        
        self.position = position
        let body = SKPhysicsBody(rectangleOfSize: size)
        body.dynamic = false
        body.categoryBitMask = Mask.OBSTACLE
        body.collisionBitMask = Mask.HERO | Mask.GROUND
        body.contactTestBitMask = Mask.HERO | Mask.GROUND
        body.allowsRotation = false
        constraints = [SKConstraint.positionX(SKRange(lowerLimit: position.x, upperLimit: position.x))]
        self.physicsBody = body
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func raise() {
        self.physicsBody?.affectedByGravity = false
        if !isRaised {
            if let scene = scene as? GameScene {
                self.runAction(SKAction.sequence([
                    SKAction.moveToY(scene.size.height * 4 / 3, duration: 1 as NSTimeInterval),
                    SKAction.runBlock({ () -> Void in
                        self.isRaised = true
                    })
                ]))
//                self.isRaised = true
            }
        }
    }
    
    func lower() {
        self.removeAllActions()
        if (isRaised) {
            physicsBody?.dynamic = true
            self.physicsBody?.affectedByGravity = true
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let scene = scene {
            var parentScene = scene as! GameScene
            parentScene.heroNode.activatedItem!.cast(self)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.GROUND, Mask.OBSTACLE): fallthrough
        case (Mask.OBSTACLE, Mask.GROUND):
            isRaised = false
            self.physicsBody?.dynamic = true
            return
        default:
            return
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    
}