//
//  GameScene.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

struct Mask {
    static let SCENE        = 0x1 << 1 as UInt32
    static let HERO         = 0x1 << 2 as UInt32
    static let UTILITY      = 0x1 << 3 as UInt32
    static let ITEM         = 0x1 << 4 as UInt32
    static let OBSTACLE     = 0x1 << 5 as UInt32
    static let GROUND       = 0x1 << 6 as UInt32
    static let EFFECT       = 0x1 << 7 as UInt32
    static let SUCCESS      = 0x1 << 8 as UInt32
}

struct NodeName {
    static let MAP          = "MapNode"
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var mapNode: MapNode!
    var heroNode: HeroNode!
    var wallNode: Wall!

    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 0)
        physicsWorld.contactDelegate = self
        
        mapNode = MapNode(size)
        addChild(mapNode)
        mapNode.createLevel1()
        
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
        buttonGoUp.position = CGPoint(
            x: size.width/2 - buttonGoUp.size.width/2,
            y: 10)
        
        addChild(buttonGoLeft)
        addChild(buttonGoRight)
        addChild(buttonGoUp)
        
        // Add hero
        heroNode = HeroNode()
        heroNode.position = CGPoint(x: (size.width - heroNode.frame.width) / 2, y: heroNode.size.height + 100)
        mapNode.addChild(heroNode)
        heroNode.constrainMovement()
        
        // Add button
        let buttonNode = Button()
        buttonNode.position = CGPoint(x: 80, y: mapNode.mesurmentsGround)
        mapNode.addChild(buttonNode)
        
        // Add wall
        let wallWidth = 30 as CGFloat
        wallNode = Wall(color: UIColor.blueColor(), size: CGSize(width: wallWidth, height: size.height),
            position: CGPoint(x: 450, y: size.height / 2 + CGFloat(mapNode.mesurmentsGround)))
        mapNode.addChild(wallNode)

        // Add item
        let itemNode = SingleTargetPhysicsBendingItem(desiredEffect: StopGravityEffect())
        itemNode.position = CGPoint(x: -200, y: mapNode.mesurmentsGround)
        itemNode.size.width = 40
        itemNode.size.height = 25
        mapNode.addChild(itemNode)

        itemNode.displayItemName()
        mapNode.addChild(itemNode.displayText!)
        
        // Add level complete thingy
        let lvlCompleteTexture = SKTexture(imageNamed: "cube.png")
        let lvlCompleteNode = LevelCompleteNode(texture: lvlCompleteTexture, size: CGSize(width: 43, height: 50))
        lvlCompleteNode.position.x = CGFloat(mapNode.endMap) - lvlCompleteNode.size.width - 20
        lvlCompleteNode.position.y = 100
        mapNode.addChild(lvlCompleteNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didFinishUpdate() {
        centerOnNode(heroNode)
    }
    
    override func update(currentTime: NSTimeInterval) {
        mapNode.updateScreenPos(self.heroNode.position)
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: mapNode)
//        let cameraPositionInScene:CGPoint = self.convertPoint(node.position, fromNode: mazeWorld!)
//        mapNode.position = CGPoint(x: mapNode.position.x - cameraPositionInScene!.x, y: mapNode.position.y - cameraPositionInScene!.y)
        mapNode.position = CGPoint(
            x: mapNode.position.x + frame.width/2 - cameraPositionInScene!.x - node.frame.width/2,
            y: -(node.position.y / 2) + CGFloat(mapNode.mesurmentsGround) * 2)
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