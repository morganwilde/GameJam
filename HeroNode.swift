//
//  HeroNode.swift
//  GameJam
//
//  Created by Morgan Wilde on 17/04/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

enum HumanBodyParts {
    case Head
    case Torso
    case Arm
    case Leg
}

func humanProportions(bodyPart: HumanBodyParts) -> (width: CGFloat, height: CGFloat) {
    switch (bodyPart) {
    case .Head:     return (0.40, 0.15)
    case .Torso:    return (0.60, 0.40)
    case .Arm:      return (0.20, 0.40)
    case .Leg:      return (0.30, 0.45)
    }
}

enum Side {
    case Left
    case Right
}

enum MovementDirection {
    case Unknown
    case Up
    case Right
    case Bottom
    case Left
}

class HeroNode: SKSpriteNode, Contactable {
    
    var items: [Item] = []
    var inventorySlots: [InventorySlot] = []
    var activatedItem: Item?
    // Textures
    var texturesWalkLeft = [SKTexture]()
    var texturesWalkRight = [SKTexture]()
    
    init() {
        let texture = SKTexture(imageNamed: "Hero.png")
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        name = "hero"
        
//        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.mass = 20000
        physicsBody?.categoryBitMask = Mask.HERO
        physicsBody?.collisionBitMask = Mask.OBSTACLE | Mask.ITEM | Mask.SCENE | Mask.GROUND
        physicsBody?.contactTestBitMask = Mask.OBSTACLE | Mask.ITEM | Mask.SCENE | Mask.GROUND
        physicsBody?.allowsRotation = false
        
        // Create the textures arrays
        for i in 0...16 {
            texturesWalkRight.append(SKTexture(imageNamed: String(format: "Walking animation%02d.png", i)))
            texturesWalkLeft.append(SKTexture(imageNamed: String(format: "walking-left-%d.png", i)))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    func moveInDirection(direction: MovementDirection) {
        var movement: SKAction
        switch (direction) {
        case .Right:    movement = SKAction.moveByX(50, y: 0, duration: 0.25)
        case .Left:     movement = SKAction.moveByX(-50, y: 0, duration: 0.25)
        default:        movement = SKAction()
        }
        
        runAction(SKAction.group([movement, animationWalkingInDirection(direction)]))
    }
    func addItem(item: Item) {
        items.append(item)
    }
    func activateItem(item: Item) {
        activatedItem = item
    }
    func deactivateItem() {
        activatedItem = nil
    }
    func hasItem(item: Item) -> Bool {
        return items.contains(item)
    }
    
    // Animations
    func animationWalkingInDirection(direction: MovementDirection) -> SKAction {
        var animation: SKAction
        switch (direction) {
        case .Right: animation = SKAction.animateWithTextures(texturesWalkRight, timePerFrame: 0.016)
        case .Left: animation = SKAction.animateWithTextures(texturesWalkLeft, timePerFrame: 0.016)
        default: animation = SKAction()
        }
        
        return animation
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == Mask.ITEM && contact.bodyB.node == self {
            var pickedUpItem = contact.bodyA.node as! Item
            if !pickedUpItem.pickedUp {
                pickedUpItem.pickedUp = true
                pickedUpItem.getCollected()
                items.append(pickedUpItem)
                addPickedUpItem(pickedUpItem)

            }
        }
        else if contact.bodyB.categoryBitMask == Mask.ITEM && contact.bodyA.node == self {
            var pickedUpItem = contact.bodyB.node as! Item
            if !pickedUpItem.pickedUp {
                pickedUpItem.pickedUp = true
                pickedUpItem.getCollected()
                items.append(pickedUpItem)
                addPickedUpItem(pickedUpItem)
            }
        }
    }
    
    func getSelectedSlot() -> InventorySlot?{
        for slot in inventorySlots {
            if activatedItem == slot.slottedItem {
                return slot
            }
        }
        return nil
    }
    
    
    func addPickedUpItem(pickedUpItem:Item){
        if let scene = scene {
            var slot = InventorySlot(hero: self, size: CGSize(width: 50, height: 50), color: SKColor.whiteColor(), title: "", onActionBegan: nil, onActionEnded: nil)
            scene.addChild(slot)
            slot.setItem(pickedUpItem)
            inventorySlots.append(slot)
            slot.position = CGPoint(x: CGFloat((inventorySlots.count-1) * 60 + 20), y: scene.frame.height - 70)
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
}