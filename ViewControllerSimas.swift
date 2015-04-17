//
//  ViewController.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import UIKit
import SpriteKit

class ViewControllerSimas: UIViewController {
    
    @IBOutlet weak var spriteView: SKView!
    
    var sceneCurrent: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneCurrent = GameScene(size: spriteView.frame.size)
        spriteView.presentScene(sceneCurrent)
        spriteView.showsPhysics = true
    }
    
}

