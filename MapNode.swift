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
    
    
    var startMap: Double = 0
    var endMap: Double = 0
    
    var cloudName: String!
    let measurmentsGround: Double = 35
    let measurmentsWall: Double = 260
    var screenPos: CGPoint = CGPoint(x: 0, y: 0)
    
    var cloudCreatedX = 0
    var cloudCreatedWidth = 0
    var cloudCreatedY = 0
    var cloudCreatedHeight = 0

    init(_ size: CGSize, name: String, cloud: String) {
        super.init(texture: nil, color: SKColor.clearColor(), size: size)
        //generateGround(0,y: 0,count: 0)
        //generateWall()
        cloudName = cloud
        self.name = NodeName.MAP
        createBackground1(name)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addObject(x: Double, y: Double){
        
    }
    
    func generateWall(x: Double, y: Double, count: Int){
        
        
        
    }
    
    func updateScreenPos(position: CGPoint) {
        
        
        //x axis cloud check
        if(position.x + 600 + self.frame.width > CGFloat(cloudCreatedWidth) + CGFloat(cloudCreatedX)){
            let fromX = cloudCreatedWidth + cloudCreatedX
            let fromY = 0
            
            cloudCreatedWidth += Int(self.frame.width)
            println(self.frame.width)
            let n = 15

            for(var i=0; i<n; i++){ // n debeseliu
                
                let sizeScale = Int(arc4random_uniform(5)) //debeselio dydis

                let xpos = Int(arc4random_uniform( UInt32(self.frame.width)))
                let ypos = Int(arc4random_uniform( UInt32(self.frame.height)))
                
                createCloud(xpos + fromX, y: ypos + fromY, scale: sizeScale)

            }

        } else if(position.x - 600 < CGFloat(cloudCreatedX)){
            cloudCreatedX -= Int(self.frame.width)
            cloudCreatedWidth += Int(self.frame.width)
            
            let fromX = cloudCreatedX
            let fromY = 0
    
            let n = 10

            for(var i=0; i<n; i++){ // n debeseliu
                
                let sizeScale = Int(arc4random_uniform(5)) //debeselio dydis

                let xpos = Int(arc4random_uniform( UInt32(self.frame.width)))
                let ypos = Int(arc4random_uniform( UInt32(self.frame.height)))
                
                createCloud(xpos + fromX, y: ypos + fromY, scale: sizeScale)

            }
            
        }
        
        //y axis cloud check (expl. like x)
        if(position.y + self.frame.height > CGFloat(cloudCreatedHeight) + CGFloat(cloudCreatedY)){
            
        }else if(position.y < CGFloat(cloudCreatedY)){
            
        }
        
        
        
    }
    
    func createClouds(){
        
        let fromX = cloudCreatedX
        let fromY = cloudCreatedY
        
        cloudCreatedWidth += Int(self.frame.width)
        cloudCreatedHeight += Int(self.frame.height)
        
        let n = 10
        
        for(var i=0; i<n; i++){ // n debeseliu
            let sizeScale = Int(arc4random_uniform(5)) //debeselio dydis
            let xpos = Int(arc4random_uniform( UInt32(self.frame.width)))
            let ypos = Int(arc4random_uniform( UInt32(self.frame.height)))
            createCloud(xpos + fromY, y: ypos + fromX, scale: sizeScale)
        }
        
    }
    
    func createCloud(x: Int, y: Int, scale: Int){
        var node = SKSpriteNode(imageNamed: cloudName)
        node.xScale = CGFloat(scale) * 0.1
        node.yScale = CGFloat(scale) * 0.1
        //node.size = CGSize(width: 50, height: 50)
        node.position = CGPoint(x: x,y: y)
        node.zPosition = -1
        addChild(node)
    }
    
    func createBackground1(name: NSString){
        var node = SKSpriteNode(imageNamed: name as String)
        node.zPosition = -1
        node.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.width*2, height: self.frame.height*2))
        node.physicsBody?.pinned = true
        node.physicsBody?.categoryBitMask = 0
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
        
    }
    
    var finishingY: Double = 0
    var finishingX: Double = 0
    
    func createLevel2() {
        let start: Double = 0
        var end: Double = generateGround(start, y: 0, count: 1)
        var bottom: Double = 0
        
        createBlock(1, blocksCountY: 50, blockWidth: end, blockHeight: measurmentsGround, startingPosX: 0, startingPosY: -measurmentsGround*50)
        

        let countY: Int = Int(self.frame.height) / Int(measurmentsWall) + 1
        createBlock(1, blocksCountY: countY, blockWidth: measurmentsWall*5, blockHeight: measurmentsWall, startingPosX: start - measurmentsWall*5, startingPosY: 0)
        

        var shift: Int = 9
        for(var i=0;i<50;i++){
            if(i%2 == 0){
                var random = Int(arc4random_uniform(3))
                if(random == 1){
                    shift++;
                }else if(random == 2){
                    shift--;
                }
            }
            
            if(i != 15 && i != 14 && i != 30 && i != 29 && i != 45 && i != 44){
                //kuriamas virsuje
                createBlock(1, blocksCountY: 10, blockWidth: measurmentsGround, blockHeight: measurmentsGround, startingPosX: end, startingPosY: -measurmentsGround*Double(shift))
                
                //kuriamas apacioje
                createBlock(1, blocksCountY: 10, blockWidth: measurmentsGround, blockHeight: measurmentsGround, startingPosX: end, startingPosY: -measurmentsGround*Double(shift) - 600)

                lowestY(-measurmentsGround*Double(shift) - 600)
                
                if (i == 5) {
                    finishingX = end
                    finishingY = -measurmentsGround*Double(shift) - 600.0 + measurmentsGround * 10
                }
            }else{
                //kuriamas virsuje
                createBlockObstacle(1, blocksCountY: 10, blockWidth: measurmentsGround, blockHeight: measurmentsGround, startingPosX: end, startingPosY: -measurmentsGround*Double(shift))
                
                //kuriamas apacioje
                createBlock(1, blocksCountY: 10, blockWidth: measurmentsGround, blockHeight: measurmentsGround, startingPosX: end, startingPosY: -measurmentsGround*Double(shift) - 600)
            }
            
            end = end + Double(measurmentsGround)
        }
        createBlock(10, blocksCountY: 1, blockWidth: measurmentsGround, blockHeight: measurmentsGround, startingPosX: end, startingPosY: -measurmentsGround*Double(shift) - 600)
    
        lowestY(-measurmentsGround*Double(shift) - 600)
        end = end + Double(measurmentsGround) * 10
//        createBlock(40, blocksCountY: 1, blockWidth: 50, blockHeight: 50, startingPosX: start, startingPosY: 0)
        startMap = start
        endMap = end
        
    }
    
    var lowest: Double = 0
    func lowestY(x: Double){
        if(lowest > x){
            lowest = x
        }
    }
    
    func createLevel1(){
        let start: Double = Double(-self.frame.width)
        let countY: Int = Int(self.frame.height) / Int(measurmentsWall) + 1
        createBlock(1, blocksCountY: countY, blockWidth: measurmentsWall*3, blockHeight: measurmentsWall, startingPosX: start - measurmentsWall*3, startingPosY: 0)
        let end: Double = generateGround(start, y: 0, count: 3)
        createBlock(1, blocksCountY: countY, blockWidth: measurmentsWall*3, blockHeight: measurmentsWall, startingPosX: end, startingPosY: 0)
        startMap = start
        endMap = end
    }
    
    var endPoint: Double!
    var startPoint: Double!
    
    func generateGround(x: Double, y: Double, count: Int) -> Double{ //count = screenwidth
        var pos = x
        let quantity = Int(self.frame.width) / Int(measurmentsGround)
        println(quantity)
        for(var i=0; i<count; i++){
            
            createBlock(quantity, blocksCountY: 1, blockWidth: measurmentsGround, blockHeight: measurmentsGround, startingPosX: pos, startingPosY: 0)
            pos += Double(quantity) * Double(measurmentsGround)
            
        }
        return Double(pos)
    }
    
    func createBlockObstacle(blocksCountX: Int, blocksCountY: Int, blockWidth: Double, blockHeight: Double, startingPosX: Double, startingPosY: Double){
        for (var i=0; i<blocksCountX; i++){
            for (var j=0; j<blocksCountY; j++){
                addChild(createObstacle(startingPosX + Double(i) * Double(blockWidth) + blockWidth/2, y: startingPosY + Double(j) * Double(blockHeight) + blockHeight/2, width: blockWidth, height: blockHeight))
            }
        }
    }
    
    func createBlock(blocksCountX: Int, blocksCountY: Int, blockWidth: Double, blockHeight: Double, startingPosX: Double, startingPosY: Double){
        for (var i=0; i<blocksCountX; i++){
            for (var j=0; j<blocksCountY; j++){
                addChild(createGround(startingPosX + Double(i) * Double(blockWidth) + blockWidth/2, y: startingPosY + Double(j) * Double(blockHeight) + blockHeight/2, width: blockWidth, height: blockHeight))
            }
        }
    }
    
    func createObstacle(x: Double, y: Double, width: Double, height: Double) -> SKSpriteNode {
     
        var trap = TrapNode(color: UIColor.clearColor(), size: CGSize(width: width, height: height), position: CGPoint(x: x, y: y))
        
        return trap
        
    }
    
    func createGround(x: Double, y: Double, width: Double, height: Double) -> SKSpriteNode {
        var groundBlock = SKSpriteNode(imageNamed: "ground.png")
        groundBlock.size = CGSize(width: width, height: height)
        groundBlock.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        groundBlock.position = CGPoint(x: x, y: y)
        groundBlock.physicsBody = SKPhysicsBody(rectangleOfSize: groundBlock.frame.size, center: CGPoint(x: 0.5, y: 0.5))
        groundBlock.physicsBody?.dynamic = false
        groundBlock.physicsBody?.categoryBitMask = Mask.GROUND
        groundBlock.physicsBody?.collisionBitMask = Mask.HERO
        groundBlock.physicsBody?.contactTestBitMask = Mask.HERO
        groundBlock.physicsBody?.affectedByGravity = false
        groundBlock.physicsBody?.allowsRotation = false
        groundBlock.physicsBody?.restitution = 0
        
        return groundBlock
    }
    
}