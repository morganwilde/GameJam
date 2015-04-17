//
//  BodyPartNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / CGFloat(180)
}
func radiansToDegrees(radians: CGFloat) -> CGFloat {
    return radians * CGFloat(180) / CGFloat(M_PI)
}
func getPointDeltaFrom(a: CGPoint, b: CGPoint) -> (x: CGFloat, y: CGFloat) {
    let deltaX = b.x - a.x
    let deltaY = b.y - a.y
    
    return (deltaX, deltaY)
}

class BodyPartNode: SKSpriteNode {
    // Initialisers
    init(size: CGSize, color: UIColor) {
        super.init(texture: nil, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods - callback
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch = touches.first as! UITouch
        
        rotateTo(touch.locationInNode(parent))
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch = touches.first as! UITouch
        
        rotateTo(touch.locationInNode(parent))
    }
    
    // Methods
    func rotateTo(target: CGPoint) {
        self.zRotation = rotationAngleTo(target)
    }
    func rotationAngleTo(target: CGPoint) -> CGFloat {
        let delta = getPointDeltaFrom(self.position, target)
        let rotation = atan2(delta.y, delta.x)
        
        return rotation - CGFloat(M_PI/2)
    }
}