//
//  GameScene.swift
//  GameJam
//
//  Created by Tautvydas Stakėnas on 4/17/15.
//  Copyright (c) 2015 Tautvydas Stakėnas. All rights reserved.
//

import Foundation
import SpriteKit

class MapNode: SKSpriteNode {
    
    
    var world: SKNode!
    
    let mesurements:Double = 50

    init(_ size: CGSize) {
        super.init(texture: nil, color: SKColor.clearColor(), size: size)
        generateGround()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addObject(x: Double, y: Double){
        
    }
    
    func generateGround(){
        
        for(var i=0;i<10;i++){
            self.addChild(createGround(Double(i)*mesurements, y: Double(0), width: mesurements, height: mesurements))
        }
        
    }
    
    func createGround(x: Double, y: Double, width: Double, height: Double) -> SKSpriteNode {
        
        var groundBlock = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: width,height: height))
        groundBlock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        groundBlock.position = CGPoint(x: x, y: y)
//        groundBlock.physicsBody = SKPhysicsBody(rectangleOfSize: groundBlock.frame.size, center: CGPoint(x: 0.5, y: 0.5))
//        groundBlock.physicsBody?.dynamic = false
//        groundBlock.physicsBody?.categoryBitMask = PhysicsCategory.Ground
//        groundBlock.physicsBody?.collisionBitMask = PhysicsCategory.All
//        groundBlock.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
//        groundBlock.physicsBody?.affectedByGravity = false
        groundBlock.zPosition = 100
//        groundBlock.physicsBody?.allowsRotation = false
        //groundBlock.lightingBitMask = ShadowCategory.All
        
        return groundBlock
        
    }
    
}