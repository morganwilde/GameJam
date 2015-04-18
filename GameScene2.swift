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
        
        mapNode = MapNode(size)
        
        mapNode.createClouds()
        mapNode.createLevel2()
        
        self.addChild(mapNode)
        
        heroNode = HeroNode()
        heroNode.position = CGPoint(x: 100, y: 500)
        mapNode.addChild(heroNode)
        heroNode.constrainMovement()
        
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
        
        buttonGoLeft.position = CGPoint(x: 10, y: 10)
        buttonGoRight.position = CGPointMake(size.width - 10 - buttonGoLeft.size.width, 10)
        
        addChild(buttonGoLeft)
        addChild(buttonGoRight)
        
    
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: NSTimeInterval) {
        mapNode.updateScreenPos(self.heroNode.position)
    }
    
    
    
}
