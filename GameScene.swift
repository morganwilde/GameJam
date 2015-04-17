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
    static let HERO         = 0x1 << 1 as UInt32
    static let UTILITY      = 0x1 << 2 as UInt32
    static let BUTTON       = 0x1 << 3 as UInt32
    static let ITEM         = 0x1 << 4 as UInt32
    static let OBSTACLE     = 0x1 << 5 as UInt32
    static let GROUND       = 0x1 << 6 as UInt32
    static let EFFECT       = 0x1 << 7 as UInt32
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
        
        // Add hero
        heroNode = HeroNode(size: CGSize(width: 100, height: 240))
        heroNode.anchorPoint = CGPoint(x: 0, y: 0)
        heroNode.position = CGPoint(x: size.width/2 - heroNode.frame.width/2, y: 100)
        mapNode.addChild(heroNode)
        
        // Add button
        let buttonNode = Button()
        buttonNode.position = CGPoint(x: 300, y: 0)
        mapNode.addChild(buttonNode)
        
        // Add wall
        wallNode = Wall(color: UIColor.blueColor(), size: CGSize(width: 50, height: size.height))
        wallNode.anchorPoint = CGPoint(x: 0, y: 0)
        wallNode.position = CGPoint(x: 450, y: 0)
        mapNode.addChild(wallNode)
        
        // Add item
        let itemNode = SingleTargetPhysicsBendingItem(parent: mapNode)
        itemNode.position = CGPoint(x: 50, y: 100)
        mapNode.addChild(itemNode)
        
        // Controls
        let buttonGoLeft = ControlNode(
            size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "Left")
        let buttonGoRight = ControlNode(
            size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "Right")
        
        buttonGoLeft.actionOnBegan = {
            self.heroNode.runAction(SKAction.moveByX(-100, y: 0, duration: 1))
        }
        
        buttonGoRight.actionOnBegan = {
            self.heroNode.runAction(SKAction.moveByX(100, y: 0, duration: 1))
        }
        
        buttonGoLeft.position = CGPoint(x: 10, y: 10)
        buttonGoRight.position = CGPoint(x: buttonGoLeft.position.x + buttonGoLeft.size.width + 10, y: 10)
        
        
        addChild(mapNode)
        
        // Controls
        addChild(buttonGoLeft)
        addChild(buttonGoRight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didFinishUpdate() {
        centerOnNode(heroNode)
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: mapNode)
        mapNode.position = CGPoint(
            x: mapNode.position.x + frame.width/2 - cameraPositionInScene!.x - node.frame.width/2,
            y: mapNode.position.y)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA as? Contactable {
            bodyA.didBeginContact(contact)
        }
        if let bodyB = contact.bodyB as? Contactable {
            bodyB.didBeginContact(contact)
        }
    }
    func didEndContact(contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA as? Contactable {
            bodyA.didEndContact(contact)
        }
        if let bodyB = contact.bodyB as? Contactable {
            bodyB.didEndContact(contact)
        }
    }
}