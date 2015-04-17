//
//  Utility.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/17/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

class Utility : SKSpriteNode, Contactable {
    
    let AUTO_REMOVAL_ACTION_KEY = "auto_remove_interaction_button"
    let REMOVE_DELAY = 3000 as NSTimeInterval
    var iNode : InteractionNode?
    
    func didBeginContact(contact: SKPhysicsContact) {
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.HERO, Mask.UTILITY): fallthrough
        case (Mask.UTILITY, Mask.HERO):
            println("Contacted with hero!")
            if (iNode == nil) {
                // Create interaction button if it doesn't exist
                iNode = InteractionNode(title: "Do you even lift?")
                addChild(iNode!)
            } else {
                // Make sure that existing button is not scheduled for removal
                removeAllActions()
            }
            return
        default:
            return
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.HERO, Mask.UTILITY): fallthrough
        case (Mask.UTILITY, Mask.HERO):
            println("Ended contact with hero!")
            // Remove interaction node after a prefixed amount of time
            runAction(SKAction.sequence([
                SKAction.waitForDuration(REMOVE_DELAY),
                SKAction.runBlock({ () -> Void in
                    self.iNode!.removeFromParent()
                    self.iNode = nil
                })
                ]), withKey: AUTO_REMOVAL_ACTION_KEY)
            return
        default:
            return
        }
    }
    
}