//
//  Contactable.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

@objc protocol Contactable {
    func didBeginContact(contact: SKPhysicsContact)
    func didEndContact(contact: SKPhysicsContact)
}

extension Array {
    func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}