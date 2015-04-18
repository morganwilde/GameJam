//
//  LevelCompleteScene.swift
//  GameJam
//
//  Created by Tautvydas Stakėnas on 4/18/15.
//  Copyright (c) 2015 Tautvydas Stakėnas. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteScene: SKScene {
    
    init(size: CGSize, level: Int) {
        super.init(size: size)
        
        var node = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: size.width, height: size.height))
        node.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(node)
        var label = SKLabelNode(text: "Level \(level). Rekt.")
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        label.fontSize = 30
        label.fontColor = UIColor.whiteColor()
        self.addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}