//
//  GameOverScene.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class GameOverScene : SKScene {
    init(size: CGSize, level: Int) {
        super.init(size: size)
        
        var node = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: size.width, height: size.height))
        node.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(node)
        var label = SKLabelNode(text: "Level \(level) failed!..")
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        label.fontSize = 30
        label.fontColor = UIColor.whiteColor()
        self.addChild(label)
        
        var clickableLabel = ClickableLabel(text: "Play Level 2 again, newbie ->",
            began: {
                
            }, ended: {
                self.view?.presentScene(GameScene2(size: size))
            }
        )
        clickableLabel.fontColor = UIColor.redColor()
        clickableLabel.position = CGPoint(x: size.width/2, y: size.height/2-50)
        self.addChild(clickableLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
