//
//  LegNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class LegNode: BodyPartNode {
    // Properties
    var width: CGFloat
    var height: CGFloat
    let side: Side
    var restDistanceFromTorso: CGFloat = 5
    
    // Properties - calculated
    var restAngle: CGFloat {
        if side == .Left {
            return rotationAngleTo(CGPoint(x: position.x - restDistanceFromTorso, y: -height))
        } else {
            return rotationAngleTo(CGPoint(x: position.x + restDistanceFromTorso, y: -height))
        }
    }
    
    // Initialisers
    init(bodySize: CGSize, side: Side) {
        width    = humanProportions(.Leg).width * bodySize.width
        height   = humanProportions(.Leg).height * bodySize.height
        
        self.side = side
        
        var leftPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        var backgroundColor: UIColor
        
        if side == .Left {
            leftPadding = width/2
            backgroundColor = UIColor.magentaColor()
        } else {
            leftPadding = humanProportions(.Torso).width * bodySize.width - width/2
            backgroundColor = UIColor.brownColor()
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
    func createStateKick() -> [SKAction] {
        let rotation = SKAction.rotateToAngle(rotationAngleTo(CGPoint(x: position.x + height, y: 0)), duration: 0.25, shortestUnitArc: true)
        let length = SKAction.scaleYTo(1.2, duration: 0.125)
        let lengthReset = SKAction.scaleYTo(1, duration: 0.25)
        let rotationReset = SKAction.rotateToAngle(restAngle, duration: 0.25, shortestUnitArc: true)
        
        return [rotation, length, lengthReset, rotationReset]
    }
    override func createPhysicsBody() {
        super.createPhysicsBody()
        
        physicsBody!.dynamic = false
    }
    /*
    func createPhysicsBody() {
        physicsBody = SKPhysicsBody(
            rectangleOfSize: CGSize(width: width, height: height),
            center: CGPoint(x: width/2 - anchorPoint.x * width, y: height/2 - anchorPoint.y * height))
        
        physicsBody!.affectedByGravity = false
        physicsBody!.pinned = true
        physicsBody!.dynamic = true
        /*
        physicsBody!.categoryBitMask = BodyCategoryPlayer
        physicsBody!.contactTestBitMask = BodyCategoryOpponent
        physicsBody!.collisionBitMask = 0
        */
    }
*/
}