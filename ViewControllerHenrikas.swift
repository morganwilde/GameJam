//
//  ViewControllerHenrikas.swift
//  GameJam
//
//  Created by Henrikas Jasiūnas on 4/17/15.
//  Copyright (c) 2015 Henrikas Jasiūnas. All rights reserved.
//

import Foundation
import SpriteKit

class ViewControllerHenrikas: UIViewController {
    
    @IBOutlet weak var spriteView: SKView!
    
    var sceneCurrent: SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneCurrent = SKScene(size: spriteView.frame.size)
        
        spriteView.presentScene(sceneCurrent)
    }
    
}
