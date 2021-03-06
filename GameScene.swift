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
        
        mapNode = MapNode(size , name: "background1.png", cloud: "cloud.png")
        addChild(mapNode)
        mapNode.createLevel1()
        
        // Controls
        // Controls
        let buttonGoLeft = ControlNode(
            size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "↢",
            onActionBegan: {
                self.heroNode.moveInDirection(.Left)
            },
            onActionEnded: {
                self.heroNode.stop()
        })
        
        let buttonGoRight = ControlNode(
            size: CGSize(width: 50, height: 50),
            color: UIColor.whiteColor(),
            title: "↣",
            onActionBegan: {
                self.heroNode.moveInDirection(.Right)
            },
            onActionEnded: {
                self.heroNode.stop()
        })
        
        buttonGoLeft.position = CGPoint(x: 10, y: 10)
        buttonGoRight.position = CGPointMake(size.width - 10 - buttonGoLeft.size.width, 10)
        
        let buttonGoUpLeft = ControlNode(size: CGSize(width: 50, height: 50),
            color: UIColor.orangeColor(),
            title: "↥",
            onActionBegan: {
                self.heroNode.jump()
            },
            onActionEnded: nil)
        
        let buttonGoUpRight = ControlNode(size: CGSize(width: 50, height: 50),
            color: UIColor.orangeColor(),
            title: "↥",
            onActionBegan: {
                self.heroNode.jump()
            },
            onActionEnded: nil)
        
        buttonGoUpLeft.position = buttonGoLeft.position
        buttonGoUpRight.position = buttonGoRight.position
        buttonGoUpLeft.controlHide()
        buttonGoUpRight.controlHide()
        
        // Button switching
        buttonGoLeft.actionOnBegan = {
            buttonGoRight.controlHide()
            buttonGoUpRight.controlShow()
            self.heroNode.moveInDirection(.Left)
        }
        buttonGoLeft.actionOnEnded = {
            buttonGoRight.controlShow()
            buttonGoUpRight.controlHide()
            self.heroNode.stop()
        }
        
        buttonGoRight.actionOnBegan = {
            buttonGoLeft.controlHide()
            buttonGoUpLeft.controlShow()
            self.heroNode.moveInDirection(.Right)
            println("began")
        }
        buttonGoRight.actionOnEnded = {
            buttonGoUpLeft.controlHide()
            buttonGoLeft.controlShow()
            self.heroNode.stop()
            println("ended")
        }
        
        // Tree
        addChild(buttonGoUpLeft)
        addChild(buttonGoUpRight)
        addChild(buttonGoLeft)
        addChild(buttonGoRight)
        
        buttonGoUpLeft.name = "buttonGoUpLeft"
        buttonGoUpRight.name = "buttonGoUpRight"
        buttonGoLeft.name = "buttonGoLeft"
        buttonGoRight.name = "buttonGoRight"
        
        // Add hero
        heroNode = HeroNode()
        heroNode.position = CGPoint(x: (size.width - heroNode.frame.width) / 2, y: heroNode.size.height + 100)
        mapNode.addChild(heroNode)
        heroNode.constrainMovement()
        
        // Add button
        let buttonNode = Button()
        buttonNode.position = CGPoint(x: 80, y: mapNode.measurmentsGround)
        mapNode.addChild(buttonNode)
        
        // Add wall
        let wallWidth = 30 as CGFloat
        // Make the wall appear at the right side of the screen when standing on the button
        let wallX = buttonNode.position.x + buttonNode.frame.width + size.width / 2 - wallWidth / 2
        let wallY = size.height + CGFloat(mapNode.measurmentsGround)
        wallNode = Wall(color: UIColor.blueColor(),
            size: CGSize(width: wallWidth, height: size.height * 2),
            position: CGPoint(x: wallX, y: wallY))
        mapNode.addChild(wallNode)

        // Add item
        let itemNode = SingleTargetPhysicsBendingItem(desiredEffect: StopGravityEffect())
        itemNode.position = CGPoint(x: -200, y: mapNode.measurmentsGround)
        itemNode.size.width = 40
        itemNode.size.height = 25
        mapNode.addChild(itemNode)

        itemNode.displayItemName()
        itemNode.addChild(itemNode.displayText!)
        
        // Add level complete thingy
        let lvlCompleteTexture = SKTexture(imageNamed: "cube.png")
        let lvlCompleteNode = LevelCompleteNode(texture: lvlCompleteTexture, size: CGSize(width: 43, height: 50), level: 1)
        lvlCompleteNode.position.x = CGFloat(mapNode.startMap) - lvlCompleteNode.size.width - 20
        lvlCompleteNode.position.y = 100
        mapNode.addChild(lvlCompleteNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didSimulatePhysics() {
        centerOnNode(heroNode)
    }
    
    override func update(currentTime: NSTimeInterval) {
        mapNode.updateScreenPos(self.heroNode.position)
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene = node.scene?.convertPoint(node.position, fromNode: mapNode)
        mapNode.position = CGPoint(
            x: mapNode.position.x + frame.width/2 - cameraPositionInScene!.x - node.frame.width/2,
            y: mapNode.position.y + frame.height/2 - cameraPositionInScene!.y - node.frame.height/2)
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