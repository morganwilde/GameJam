//
//  ControlNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class ControlNode: SKSpriteNode {
    
    var actionOnBegan: (()->())?
    var actionOnEnded: (()->())?
    var positionActual: CGPoint!
    
    init(size: CGSize, color: UIColor, title: String, onActionBegan: (()->())?, onActionEnded: (()->())?) {
        actionOnBegan = onActionBegan
        actionOnEnded = onActionEnded
        
        let backgroundImage = SKTexture(imageNamed: "button-background-2")
        
        super.init(texture: backgroundImage, color: color, size: size)
        
        name = "control"
        
        colorBlendFactor = 1
        zPosition = 100
        
        userInteractionEnabled = true
        anchorPoint = CGPoint(x: 0, y: 0)
        
        let labelNode = ControlNodeLabel(labelText: title)
        labelNode.userInteractionEnabled = false
        labelNode.text = title
        labelNode.fontColor = color
        labelNode.fontSize = 40
        labelNode.fontName = "Menlo-Regular"
        labelNode.position = CGPoint(x: size.width/2, y: size.height/2)
        labelNode.horizontalAlignmentMode = .Center
        labelNode.verticalAlignmentMode = .Center
        
        addChild(labelNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if let actionOnBegan = actionOnBegan {
            actionOnBegan()
        }
        println("clicked control named: \(name)")
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        if let actionOnEnded = actionOnEnded {
            actionOnEnded()
        }
    }
    
    func controlShow() {
        position = positionActual
        hidden = false
        userInteractionEnabled = true
    }
    func controlHide() {
        positionActual = position
        userInteractionEnabled = false
        hidden = true
        position = CGPoint(x: -100, y: 0)
    }
}