//
//  InteractionNode.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/18/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

class InteractionNode : SKSpriteNode {
    
    struct Const {
        static let DEFAULT_BG_WIDTH    = 150 as CGFloat
        static let DEFAULT_BG_HEIGHT   = 150 as CGFloat
        static let DEFAULT_BUTTON_WIDTH    = 120 as CGFloat
        static let DEFAULT_BUTTON_HEIGHT   = 70 as CGFloat // ToDo sizes based on screen size
    }
    
    init(title : String) {
        super.init(texture: nil, color: UIColor.grayColor().colorWithAlphaComponent(0.5), size: CGSizeMake(150, 150))
      
        anchorPoint = CGPointMake(0, 0)
        
        // Button node
        let buttonNode = ControlNode(size: CGSizeMake(Const.DEFAULT_BUTTON_WIDTH, Const.DEFAULT_BUTTON_HEIGHT),
            color: UIColor.redColor(),
            title: title,
            onActionBegan: nil,
            onActionEnded: nil)
        buttonNode.position = CGPointMake((size.width - buttonNode.size.width) / 2,
            (size.height - buttonNode.size.height) / 2)
        addChild(buttonNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}