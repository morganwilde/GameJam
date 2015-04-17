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
    
    
    let mesurmentsGround: Double = 50
    let mesurmentsWall: Double = 200
    

    init(_ size: CGSize) {
        super.init(texture: nil, color: SKColor.clearColor(), size: size)
        generateGround(0,y: 0,count: 0)
        //generateWall()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addObject(x: Double, y: Double){
        
    }
    
    func generateWall(x: Double, y: Double, count: Int){
        
        
        
    }
    
    var endPoint: Double!
    var startPoint: Double!
    
    func generateGround(x: Double, y: Double, count: Int){ //count = screenwidth
        
        createGroundBlock(20, blocksCountY: 10, blockWidth: mesurmentsGround, blockHeight: mesurmentsGround, startingPosX: 0, startingPosY: 0)
        
//        for(var i = 0; i < 20; i++){
//            
//            self.addChild(createGround(Double(i)*mesurmentsGround + mesurmentsGround/2, y: mesurmentsGround/2, width: mesurmentsGround, height: mesurmentsGround))
//            
//        }
        
    }
    
    func createGroundBlock(blocksCountX: Int, blocksCountY: Int, blockWidth: Double, blockHeight: Double, startingPosX: Double, startingPosY: Double){
        
        for(var i=0; i<blocksCountX; i++){
            for(var j=0; j<blocksCountY; j++){
                addChild(createGround(startingPosX + Double(i * blocksCountX) + blockWidth/2, y: startingPosY + Double(j * blocksCountY) + blockHeight/2, width: blockWidth, height: blockHeight))
            }
        }
        
    }
    
    func createGround(x: Double, y: Double, width: Double, height: Double) -> SKSpriteNode {
        
        var groundBlock = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: width,height: height))
        groundBlock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        groundBlock.position = CGPoint(x: x, y: y)
        groundBlock.physicsBody = SKPhysicsBody(rectangleOfSize: groundBlock.frame.size, center: CGPoint(x: 0.5, y: 0.5))
        groundBlock.physicsBody?.dynamic = false
        groundBlock.physicsBody?.categoryBitMask = Mask.GROUND
        groundBlock.physicsBody?.collisionBitMask = Mask.HERO
        groundBlock.physicsBody?.contactTestBitMask = Mask.HERO
        groundBlock.physicsBody?.affectedByGravity = false
        groundBlock.physicsBody?.allowsRotation = false
        
        return groundBlock
        
    }
    
}