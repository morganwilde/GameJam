//
//  ViewController.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import UIKit
import SpriteKit

class ViewControllerArunas: UIViewController {
    
    @IBOutlet weak var spriteView: SKView!
    
    var sceneCurrent: SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneCurrent = SKScene(size: spriteView.frame.size)
        
        let testNode = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
        testNode.anchorPoint = CGPoint(x: 0, y: 0)
        testNode.position = CGPoint(x: 10, y: 10)
        
        sceneCurrent.addChild(testNode)
        sceneCurrent.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
        spriteView.presentScene(sceneCurrent)
        
        let testItem = SingleTargetPhysicsBendingItem(desiredEffect: StopGravityEffect())
        testItem.position = CGPoint(x: 200, y: 250)
        sceneCurrent.addChild(testItem)
    }
    
}

