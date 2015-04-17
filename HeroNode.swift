//
//  HeroNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

enum HumanBodyParts {
    case Head
    case Torso
    case Arm
    case Leg
}

func humanProportions(bodyPart: HumanBodyParts) -> (width: CGFloat, height: CGFloat) {
    switch (bodyPart) {
    case .Head:     return (0.40, 0.15)
    case .Torso:    return (0.60, 0.40)
    case .Arm:      return (0.20, 0.40)
    case .Leg:      return (0.30, 0.45)
    }
}

enum Side {
    case Left
    case Right
}

enum MovementDirection {
    case Unknown
    case Up
    case Right
    case Bottom
    case Left
}

class HeroNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Hero.png")
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        anchorPoint = CGPoint(x: 0, y: 0)
        
        physicsBody = SKPhysicsBody(
            rectangleOfSize: frame.size,
            center: CGPoint(x: frame.width/2, y: frame.height/2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    func moveInDirection(direction: MovementDirection) {
        var movement: SKAction
        switch (direction) {
        case .Right:    movement = SKAction.moveToX(position.x + 100, duration: 0.25)
        case .Left:     movement = SKAction.moveToX(position.x - 100, duration: 0.25)
        default:        movement = SKAction()
        }
        
        runAction(movement)
    }
}