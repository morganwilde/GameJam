//
//  ViewControllerMorgan.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class ViewControllerMorgan: UIViewController {
    
    @IBOutlet weak var spriteView: SKView!
    
    var sceneCurrent: SKScene!
    var heroNode: HeroNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneCurrent = SKScene(size: spriteView.frame.size)
        
        heroNode = HeroNode(size: CGSize(width: 100, height: 240))
        heroNode.anchorPoint = CGPoint(x: 0, y: 0)
        heroNode.position = CGPoint(
            x: sceneCurrent.size.width/2 - heroNode.size.width/2,
            y: sceneCurrent.size.height/2 - heroNode.size.height/2)
        
        sceneCurrent.addChild(heroNode)
        
        spriteView.presentScene(sceneCurrent)
    }
    
}