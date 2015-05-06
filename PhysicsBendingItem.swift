//
//  PhysicsBendingItem.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/17/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class PhysicsBendingItem : Item{
    
    var durationOfEffect:Double = 0
    var effect: Effect?
    var displayText:SKNode?

    
    init(desiredEffect:Effect) {
        super.init()
        effect = desiredEffect
        name = "Physics bending item"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getCollected() {
        super.getCollected()
        displayText?.runAction(SKAction.removeFromParent())
    }
    
    override func cast(target:SKNode){
        
    }
    
    func displayItemName(){
        var text = SKLabelNode(fontNamed: "Arial")
        text.text = "\(name!) of \(effect!.name!)"
        text.fontColor = SKColor.whiteColor()
        text.fontSize = 12
        var background = SKSpriteNode(texture: nil, color: SKColor.blackColor(), size: text.frame.size)
        
        background.position = CGPoint(x: 0, y: background.frame.height + text.frame.height)
        text.position = CGPoint.zeroPoint
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        text.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        background.zPosition = text.zPosition+1
        
        background.addChild(text)
        
        displayText = background
        
        println("Added the text")
//        text.runAction(
//            SKAction.sequence([
//                SKAction.repeatActionForever(SKAction.sequence([
//                    SKAction.waitForDuration(0.01)])),
//                    SKAction.runBlock(background.removeFromParent)
//            ])
//        )
    
        
    }
}
