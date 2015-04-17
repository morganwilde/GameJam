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
    
    var sceneCurrent: SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneCurrent = SKScene(size: spriteView.frame.size)
        sceneCurrent.scaleMode = .ResizeFill
        
        spriteView.showsFPS = true
        spriteView.showsNodeCount = true
        spriteView.showsPhysics = true
        spriteView.multipleTouchEnabled = true
        
//        let testNode = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
//        testNode.anchorPoint = CGPoint(x: 0, y: 0)
//        testNode.position = CGPoint(x: 10, y: 10)
//        
//        sceneCurrent.addChild(testNode)
        
        var mapNode = MapNode(spriteView.frame.size)
        
        sceneCurrent.addChild(mapNode)
        
        spriteView.presentScene(sceneCurrent)
    }

    
}