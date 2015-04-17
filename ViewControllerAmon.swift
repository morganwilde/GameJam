//
//  ViewControllerAmon.swift
//  GameJam
//
//  Created by Tautvydas Stakėnas on 4/17/15.
//  Copyright (c) 2015 Tautvydas Stakėnas. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ViewControllerAmon: UIViewController {
    
    @IBOutlet weak var spriteView: SKView!
    
    var sceneCurrent: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneCurrent = GameScene(size: spriteView.frame.size)
        
        spriteView.presentScene(sceneCurrent)
    }

    
}