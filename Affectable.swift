//
//  Affectable.swift
//  GameJam
//
//  Created by Simas Abramovas on 4/18/15.
//  Copyright (c) 2015 Simas Abramovas. All rights reserved.
//

import Foundation
import SpriteKit

@objc protocol Affectable {
    
    var affected: Bool { get set }      //read-write
    
}