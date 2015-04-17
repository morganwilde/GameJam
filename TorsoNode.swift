//
//  TorsoNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class TorsoNode: BodyPartNode {
    // Properties
    var width: CGFloat
    var height: CGFloat
    
    // Initialisers
    init(bodySize: CGSize) {
        width    = humanProportions(.Torso).width * bodySize.width
        height   = humanProportions(.Torso).height * bodySize.height
        
        var leftPadding: CGFloat = bodySize.width/2 - width/2
        var topPadding: CGFloat = humanProportions(.Leg).height * bodySize.height
        var backgroundColor = UIColor.redColor()
        
        super.init(size: CGSize(width: width, height: height), color: backgroundColor)
        
        position = CGPoint(x: leftPadding, y: topPadding)
        anchorPoint = CGPoint(x: 0, y: 0)
        userInteractionEnabled = false
        
        createPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    func stateActivateRest() {
        zRotation = 0
    }
    func createPhysicsBody() {
        physicsBody = SKPhysicsBody(
            rectangleOfSize: CGSize(width: width, height: height),
            center: CGPoint(x: width/2 - anchorPoint.x * width, y: height/2 - anchorPoint.y * height))
        
        physicsBody!.affectedByGravity = false
    }
}