//
//  ControlNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class ControlNode: SKSpriteNode {
    
    let actionOnBegan: (()->())?
    let actionOnEnded: (()->())?
    
    init(size: CGSize, color: UIColor, title: String, onActionBegan: (()->())?, onActionEnded: (()->())?) {
        actionOnBegan = onActionBegan
        actionOnEnded = onActionEnded
        super.init(texture: nil, color: color, size: size)
        
        userInteractionEnabled = true
        anchorPoint = CGPoint(x: 0, y: 0)
        
        let labelNode = ClickableLabel(text: title, began: onActionBegan, ended: onActionEnded)
        labelNode.fontColor = UIColor.blackColor()
        labelNode.fontSize = 16
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
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        if let actionOnEnded = actionOnEnded {
            actionOnEnded()
        }
    }
}