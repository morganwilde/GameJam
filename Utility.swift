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
    
    func didBeginContact(contact: SKPhysicsContact) {
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.HERO, Mask.UTILITY): fallthrough
        case (Mask.UTILITY, Mask.HERO):
            println("contact began with  hero")
            return
        default:
            return
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (Mask.HERO, Mask.UTILITY): fallthrough
        case (Mask.UTILITY, Mask.HERO):
            println("contact ended with hero")
            return
        default:
            return
        }
    }
    
}