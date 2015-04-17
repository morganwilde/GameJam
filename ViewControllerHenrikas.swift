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
        
        let testNode = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
        testNode.anchorPoint = CGPoint(x: 0, y: 0)
        testNode.position = CGPoint(x: 10, y: 10)
        
        sceneCurrent.addChild(testNode)
        
        spriteView.presentScene(sceneCurrent)
    }
    
}