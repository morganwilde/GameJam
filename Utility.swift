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
    let REMOVE_DELAY = 1 as NSTimeInterval
    var interactionNode : InteractionNode?

    
    
    func didBeginContact(contact: SKPhysicsContact) {
        println(contact.hashValue)
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.HERO, Mask.UTILITY): fallthrough
        case (Mask.UTILITY, Mask.HERO):
            println("Contacted with hero!")
            if (interactionNode == nil) {
                // Create interaction button if it doesn't exist
                interactionNode = InteractionNode(title: "Do you even lift?")
                interactionNode!.position = CGPointMake((scene!.size.width - interactionNode!.size.width) / 2, (scene!.size.height - interactionNode!.size.height) / 2)
                scene!.addChild(interactionNode!)
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
            println("\(contact.contactPoint.x), \(contact.contactPoint.y)")
            // Remove interaction node after a prefixed amount of time
            runAction(SKAction.sequence([
                SKAction.waitForDuration(REMOVE_DELAY),
                SKAction.runBlock({ () -> Void in
                    println("Removal action run")
                    if let interactionNode = self.interactionNode {
                        self.interactionNode!.removeFromParent()
                        self.interactionNode = nil
                    }
                })
            ]), withKey: AUTO_REMOVAL_ACTION_KEY)
            return
        default:
            return
        }
    }
    
}