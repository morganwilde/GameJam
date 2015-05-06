//
//  ViewController.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var spriteView: SKView!
    
    var sceneCurrent: GameScene!
    var scene2 : GameScene2!
    var level1CompleteScene: LevelCompleteScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        spriteView.showsPhysics = true
        
        sceneCurrent = GameScene(size: spriteView.frame.size)
        scene2 = GameScene2(size: spriteView.frame.size)
        spriteView.presentScene(sceneCurrent)
//        spriteView.presentScene(scene2)
    }
    
}

