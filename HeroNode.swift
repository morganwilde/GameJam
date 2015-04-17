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
    //
    // Properties
    //
    // Body parts
//    var headNode: HeadNode
//    var torsoNode: TorsoNode
//    var armLeftNode: ArmNode
//    var armRightNode: ArmNode
//    var legLeftNode: LegNode
//    var legRightNode: LegNode
    
    init(size: CGSize) {
        // Body part nodes
//        headNode        = HeadNode(bodySize: size)
//        torsoNode       = TorsoNode(bodySize: size)
//        armLeftNode     = ArmNode(bodySize: size, side: .Left)
//        armRightNode    = ArmNode(bodySize: size, side: .Right)
//        legLeftNode     = LegNode(bodySize: size, side: .Left)
//        legRightNode    = LegNode(bodySize: size, side: .Right)
        
        let texture = SKTexture(imageNamed: "Hero.png")
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        anchorPoint = CGPoint(x: 0, y: 0)
        
//        torsoNode.addChild(headNode)
//        torsoNode.addChild(legLeftNode)
//        torsoNode.addChild(legRightNode)
//        torsoNode.addChild(armLeftNode)
//        torsoNode.addChild(armRightNode)
//        
//        addChild(torsoNode)
        physicsBody = SKPhysicsBody(
            rectangleOfSize: frame.size,
            center: CGPoint(x: frame.width/2, y: frame.height/2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
//    func stateActivateRest() {
//        headNode.stateActivateRest()
//        torsoNode.stateActivateRest()
//        armLeftNode.stateActivateRest()
//        armRightNode.stateActivateRest()
//        legLeftNode.stateActivateRest()
//        legRightNode.stateActivateRest()
//    }
//    func stateActivatePunch() {
//        armRightNode.runAction(SKAction.sequence(armRightNode.createStatePunch())) {
//            self.stateActivateRest()
//        }
//    }
//    func stateActivateKick() {
//        legRightNode.runAction(SKAction.sequence(legRightNode.createStateKick())) {
//            self.stateActivateRest()
//        }
//    }
//    func stateMoveInDirection(direction: MovementDirection) {
//        var movement: SKAction
//        switch (direction) {
//        case .Up: movement = SKAction.moveToY(torsoNode.position.y + 10, duration: 0.25)
//        case .Right: movement = SKAction.moveToX(torsoNode.position.x + 10, duration: 0.25)
//        case .Bottom: movement = SKAction.moveToY(torsoNode.position.y - 10, duration: 0.25)
//        case .Left: movement = SKAction.moveToX(torsoNode.position.x - 10, duration: 0.25)
//        case .Unknown: movement = SKAction()
//        }
//        
//        torsoNode.runAction(movement)
//    }
}