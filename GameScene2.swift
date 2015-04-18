//
//  GameScene2.swift
//  GameJam
//
//  Created by Tautvydas Stakėnas on 4/18/15.
//  Copyright (c) 2015 Tautvydas Stakėnas. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene2: SKScene, SKPhysicsContactDelegate {
    
    var heroNode: HeroNode!
    var mapNode: MapNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        
        anchorPoint = CGPoint(x: 0, y: 0)
        physicsWorld.contactDelegate = self
        
        mapNode = MapNode(size, name: "background4.png", cloud: "cloud1.png")
        
        mapNode.createClouds()
        mapNode.createLevel2()
        
        self.addChild(mapNode)
        
        heroNode = HeroNode()
        heroNode.position = CGPoint(x: 100, y: 500)
        mapNode.addChild(heroNode)
        heroNode.constrainMovement()
        
        var physicsItem = SingleTargetPhysicsBendingItem(desiredEffect: RemoveCollisionsEffect())
        physicsItem.position = CGPoint(x: 300, y: 600)
        mapNode.addChild(physicsItem)
        physicsItem.displayItemName()
        mapNode.addChild(physicsItem.displayText!)
        
        // Controls
        let buttonGoLeft = ControlNode(
            size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "Left",
            onActionBegan: {
                self.heroNode.moveInDirection(.Left)
            },
            onActionEnded: {
                self.heroNode.stop()
        })
        
        let buttonGoRight = ControlNode(
            size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "Right",
            onActionBegan: {
                self.heroNode.moveInDirection(.Right)
            },
            onActionEnded: {
                self.heroNode.stop()
        })
        
        let buttonGoUp = ControlNode(size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "Jump",
            onActionBegan: { self.heroNode.jump() },
            onActionEnded: nil)
        
        buttonGoLeft.position = CGPoint(x: 10, y: 10)
        buttonGoRight.position = CGPointMake(size.width - 10 - buttonGoLeft.size.width, 10)
        buttonGoUp.position = CGPoint(x: size.width - 10 - buttonGoUp.size.width, y: 70)
        
        addChild(buttonGoLeft)
        addChild(buttonGoRight)
        addChild(buttonGoUp)
        
    
    }
    
    override func didFinishUpdate() {
        centerOnNode(heroNode)
    }
    
    func centerOnNode(node: SKNode) {
        let nodesVisibleBelow = 3 as CGFloat
        let cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: mapNode)
        mapNode.position = CGPoint(
            x: mapNode.position.x + frame.width/2 - cameraPositionInScene!.x - node.frame.width/2,
            y: mapNode.position.y + frame.height/2 - cameraPositionInScene!.y - node.frame.height/2 + (CGFloat(mapNode.mesurmentsGround) * nodesVisibleBelow / 2))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA.node as? Contactable {
            bodyA.didBeginContact(contact)
        }
        if let bodyB = contact.bodyB.node as? Contactable {
            bodyB.didBeginContact(contact)
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA.node as? Contactable {
            bodyA.didEndContact(contact)
        }
        if let bodyB = contact.bodyB.node as? Contactable {
            bodyB.didEndContact(contact)
        }
    }
    
    
}
