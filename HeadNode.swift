//
//  HeadNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class HeadNode: BodyPartNode {
    // Properties
    var width: CGFloat
    var height: CGFloat
    
    // Initialisers
    init(bodySize: CGSize) {
        width    = humanProportions(.Head).width * bodySize.width
        height   = humanProportions(.Head).height * bodySize.height
        
        var leftPadding: CGFloat = humanProportions(.Torso).width * bodySize.width/2
        var topPadding: CGFloat = humanProportions(.Torso).height * bodySize.height
        var backgroundColor = UIColor.orangeColor()
        
        super.init(size: CGSize(width: width, height: height), color: backgroundColor)
        
        position = CGPoint(x: leftPadding, y: topPadding)
        anchorPoint = CGPoint(x: 0.5, y: 0)
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
        physicsBody!.pinned = true
    }
}