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
    
    var sceneCurrent: SKScene
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spriteView = 
        
        spriteView.presentScene(sceneCurrent)
    }

}

