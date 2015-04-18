//
//  Wall.swift
//  GameJam
//
//  Created by Henrikas Jasiūnas on 4/17/15.
//  Copyright (c) 2015 Henrikas Jasiūnas. All rights reserved.
//

import Foundation
import SpriteKit

class Wall : Obstacle, Contactable, Affectable {
    
    var affected: Bool = false
    let defaultWidth = 20
    let defaultHeight = 100
    var isRaised = false
    let RAISE_ACTION = "raise_action"
    
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
        self.physicsBody = body
        constraints = [SKConstraint.positionX(SKRange(lowerLimit: position.x, upperLimit: position.x))]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    func raise() {
        physicsBody?.dynamic = false
        if !isRaised {
            if let scene = scene as? GameScene {
                isRaised = true
                runAction(SKAction.moveToY(scene.size.height * 4 / 3, duration: 1 as NSTimeInterval),
                    withKey: RAISE_ACTION)
            }
        }
    }
    
    func lower() {
        removeActionForKey(RAISE_ACTION)
        if (!affected && isRaised) {
            physicsBody?.dynamic = true
            println("dynamic on")
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let scene = scene as? GameScene {
            if let item = scene.heroNode.activatedItem {
                item.cast(self)
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.GROUND, Mask.OBSTACLE): fallthrough
        case (Mask.OBSTACLE, Mask.GROUND):
            if contact.bodyA.categoryBitMask == Mask.OBSTACLE {
                println("BodyA: \(contact.bodyA.velocity.dx) \(contact.bodyA.velocity.dy)")
            } else {
                println("BodyB: \(contact.bodyB.velocity.dx) \(contact.bodyB.velocity.dy)")
            }
            if contact.collisionImpulse < 170 {
                physicsBody?.dynamic = false
                isRaised = false
            }
            return
        default:
            return
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
}