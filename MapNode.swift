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
    
    let mesurmentsGround: Double = 50
    let mesurmentsWall: Double = 200
    var screenPos: CGPoint = CGPoint(x: 0, y: 0)
    
    var cloudCreatedX = 0
    var cloudCreatedWidth = 0
    var cloudCreatedY = 0
    var cloudCreatedHeight = 0

    init(_ size: CGSize) {
        super.init(texture: nil, color: SKColor.clearColor(), size: size)
        //generateGround(0,y: 0,count: 0)
        //generateWall()
        self.name = NodeName.MAP
        createLevel1()
        createBackground1()
        //createClouds()
        createLevel2()
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
        if(position.x + 400 + self.frame.width > CGFloat(cloudCreatedWidth) + CGFloat(cloudCreatedX)){
            //x axis: cloud x + width < camera x + frame
            
            println("FFFFFFFFFFF")
            
            let fromX = cloudCreatedWidth + cloudCreatedX
            let fromY = 0
            
            cloudCreatedWidth += Int(self.frame.width)
            println(self.frame.width)
            let n = 10

            for(var i=0; i<n; i++){ // n debeseliu
                
                let sizeScale = Int(arc4random_uniform(5)) //debeselio dydis

                let xpos = Int(arc4random_uniform( UInt32(self.frame.width)))
                let ypos = Int(arc4random_uniform( UInt32(self.frame.height)))
                
                createCloud(xpos + fromX, y: ypos + fromY, scale: sizeScale)

            }

        }else if(position.x - 400 < CGFloat(cloudCreatedX)){
            //x axis: cloud x > camera x

            println("GGGGGGGGGGG")

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
        var node = SKSpriteNode(imageNamed: "cloud.png")
        node.xScale = CGFloat(scale) * 0.1 + 0.3
        node.yScale = CGFloat(scale) * 0.1 + 0.3
        //node.size = CGSize(width: 50, height: 50)
        node.position = CGPoint(x: x,y: y)
        node.zPosition = -1
        addChild(node)
    }
    
    func createBackground1(){
        var node = SKSpriteNode(imageNamed: "background1.png")//, size: CGSize(width: self.frame.width, height: self.frame.height))
        //node.size = CGSize(width: self.frame.width*2, height: self.frame.height*2)
        //node.position = CGPoint(x: self.frame.width/2,y: self.frame.height/2)
        node.zPosition = -1
        node.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.width*2, height: self.frame.height*2))
        node.physicsBody?.pinned = true
        node.physicsBody?.categoryBitMask = 0
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
        
    }
    
    func createLevel2() {
        
//        var ground = createGround(300, y: 300, width: 50, height: 50)//(1, blocksCountY: 1, blockWidth: 50, blockHeight: 50, startingPosX: 300, startingPosY: 300)
//        var sprite = randomObj()
//        addChild(ground)
//        addChild(sprite)
        
        
        
    }
    
    func randomObj() -> SKSpriteNode {
        
        var sprite = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50,height: 50))
        sprite.position = CGPoint(x: 200,y: 200)
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50,height: 50), center: CGPoint(x: 0.5, y: 0.5))
        //addChild(sprite)
        return sprite
    }
    
    
    func createLevel1(){
        
        let start: Double = Double(-self.frame.width)
        let countY: Int = Int(self.frame.height) / Int(mesurmentsWall) + 1
        createBlock(1, blocksCountY: countY, blockWidth: mesurmentsWall*3, blockHeight: mesurmentsWall, startingPosX: start - mesurmentsWall*3, startingPosY: 0)
        let end: Double = generateGround(start, y: 0, count: 3)
        createBlock(1, blocksCountY: countY, blockWidth: mesurmentsWall*3, blockHeight: mesurmentsWall, startingPosX: end, startingPosY: 0)
        startMap = start
        endMap = end
    }
    
    var endPoint: Double!
    var startPoint: Double!
    
    func generateGround(x: Double, y: Double, count: Int) -> Double{ //count = screenwidth
        
        var pos = x
        let quantity = Int(self.frame.width) / Int(mesurmentsGround)
        println(quantity)
        for(var i=0; i<count; i++){
            
            createBlock(quantity, blocksCountY: 1, blockWidth: mesurmentsGround, blockHeight: mesurmentsGround, startingPosX: pos, startingPosY: 0)
            pos += Double(quantity) * Double(mesurmentsGround)
            
        }
        return Double(pos)
        
//        for(var i = 0; i < 20; i++){
//            
//            self.addChild(createGround(Double(i)*mesurmentsGround + mesurmentsGround/2, y: mesurmentsGround/2, width: mesurmentsGround, height: mesurmentsGround))
//            
//        }
        
    }
    
    func createBlock(blocksCountX: Int, blocksCountY: Int, blockWidth: Double, blockHeight: Double, startingPosX: Double, startingPosY: Double){
        
        for(var i=0; i<blocksCountX; i++){
            for(var j=0; j<blocksCountY; j++){
                addChild(createGround(startingPosX + Double(i) * Double(blockWidth) + blockWidth/2, y: startingPosY + Double(j) * Double(blockHeight) + blockHeight/2, width: blockWidth, height: blockHeight))
            }
        }
        
    }
    
    func createGround(x: Double, y: Double, width: Double, height: Double) -> SKSpriteNode {
        
        var groundBlock = SKSpriteNode(imageNamed: "ground.png")
        //var groundBlock = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: width,height: height))
        groundBlock.size = CGSize(width: width,height: height)
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