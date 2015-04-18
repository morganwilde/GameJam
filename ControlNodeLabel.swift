//
//  ControlNodeLabel.swift
//  GameJam
//
//  Created by Morgan Wilde on 18/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class ControlNodeLabel: SKLabelNode {
    override init() {
        super.init()
        fontName = "Menlo-Regular"
        userInteractionEnabled = true
    }
    init(labelText: String) {
        super.init(fontNamed: "Menlo-Regular")
        text = labelText
        userInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        parent!.touchesBegan(touches, withEvent: event)
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        parent!.touchesMoved(touches, withEvent: event)
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        parent!.touchesEnded(touches, withEvent: event)
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        parent!.touchesCancelled(touches, withEvent: event)
    }
}