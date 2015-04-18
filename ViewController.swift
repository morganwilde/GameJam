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
        
        scene2 = GameScene2(size: spriteView.frame.size)
        sceneCurrent = GameScene(size: spriteView.frame.size)
        level1CompleteScene = LevelCompleteScene(size: spriteView.frame.size, level: 1)
        
        //spriteView.presentScene(scene2)
        
        //level1Complete()
        spriteView.presentScene(sceneCurrent)
        
        
        spriteView.showsPhysics = true
    }
    
    func level1Complete() {
        spriteView.presentScene(level1CompleteScene)
    }
    
}

