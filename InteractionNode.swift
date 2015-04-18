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
        static let DEFAULT_BG_WIDTH    = 130 as CGFloat
        static let DEFAULT_BG_HEIGHT   = 70 as CGFloat
        static let DEFAULT_BUTTON_WIDTH    = 110 as CGFloat
        static let DEFAULT_BUTTON_HEIGHT   = 50 as CGFloat // ToDo sizes based on screen size
    }
    
    let button: ControlNodeOld
    
    
    init(title: String, onActionBegan: (() -> ())?, onActionEnded: (() -> ())?) {
        button = ControlNodeOld(size: CGSizeMake(Const.DEFAULT_BUTTON_WIDTH, Const.DEFAULT_BUTTON_HEIGHT),
            color: UIColor.blackColor(),
            title: title,
            onActionBegan: onActionBegan,
            onActionEnded: onActionEnded)
        
        super.init(texture: nil, color: UIColor.grayColor().colorWithAlphaComponent(0.5), size: CGSizeMake(Const.DEFAULT_BG_WIDTH, Const.DEFAULT_BG_HEIGHT))
        anchorPoint = CGPointMake(0, 0)
        
        button.position = CGPointMake((size.width - button.size.width) / 2, (size.height - button.size.height) / 2)

        addChild(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}