//
//  ArmNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class ArmNode: BodyPartNode {
    // Properties
    var width: CGFloat
    var height: CGFloat
    let side: Side
    var restDistanceFromTorso: CGFloat = 10
    
    // Properties - calculated
    var restAngle: CGFloat {
        if side == .Left {
            return rotationAngleTo(CGPoint(x: position.x - restDistanceFromTorso, y: 0))
        } else {
            return rotationAngleTo(CGPoint(x: position.x + restDistanceFromTorso, y: 0))
        }
    }
    
    // Initialisers
    init(bodySize: CGSize, side: Side) {
        width    = humanProportions(.Arm).width * bodySize.width
        height   = humanProportions(.Arm).height * bodySize.height
        
        self.side = side
        
        var leftPadding: CGFloat = 0
        var topPadding: CGFloat = humanProportions(.Torso).height * bodySize.height
        var backgroundColor: UIColor
        
        if side == .Left {
            leftPadding = -width/2
            backgroundColor = UIColor.blueColor()
        } else {
            leftPadding = humanProportions(.Torso).width * bodySize.width + width/2
            backgroundColor = UIColor.greenColor()
        }
        
        super.init(size: CGSize(width: width, height: height), color: backgroundColor)
        
        position = CGPoint(x: leftPadding, y: topPadding)
        anchorPoint = CGPoint(x: 0.5, y: 0)
        zRotation = restAngle
        userInteractionEnabled = true
        
        createPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    func stateActivateRest() {
        zRotation = restAngle
    }
    func createStatePunch() -> [SKAction] {
        let rotation = SKAction.rotateToAngle(rotationAngleTo(CGPoint(x: position.x + height, y: position.y)), duration: 0.25, shortestUnitArc: true)
        let length = SKAction.scaleYTo(1.2, duration: 0.125)
        let lengthReset = SKAction.scaleYTo(1, duration: 0.25)
        let rotationReset = SKAction.rotateToAngle(restAngle, duration: 0.25, shortestUnitArc: true)
        
        return [rotation, length, lengthReset, rotationReset]
    }
    func createPhysicsBody() {
        physicsBody = SKPhysicsBody(
            rectangleOfSize: CGSize(width: width, height: height),
            center: CGPoint(x: width/2 - anchorPoint.x * width, y: height/2 - anchorPoint.y * height))
        
        physicsBody!.affectedByGravity = false
        physicsBody!.pinned = true
        physicsBody!.dynamic = true
    }
}