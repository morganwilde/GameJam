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

class HeroNode: SKSpriteNode, Contactable, Affectable {
    
    var items: [Item] = []
    var inventorySlots: [InventorySlot] = []
    var activatedItem: Item?
    var footing:NSInteger = 0
    var affected:Bool = false
    // Textures
    var texturesWalkLeft = [SKTexture]()
    var texturesWalkRight = [SKTexture]()
    
    init() {
        let texture = SKTexture(imageNamed: "Hero.png")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(texture.size().width / 2, texture.size().height / 2))
        
        name = "hero"
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.dynamic = true
        physicsBody?.categoryBitMask = Mask.HERO
        physicsBody?.collisionBitMask = Mask.OBSTACLE | Mask.ITEM | Mask.SCENE | Mask.GROUND
        physicsBody?.contactTestBitMask = Mask.OBSTACLE | Mask.ITEM | Mask.SCENE | Mask.GROUND
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false;
        
        userInteractionEnabled = true
        // Create the textures arrays
        for i in 0...16 {
            texturesWalkRight.append(SKTexture(imageNamed: String(format: "Walking animation%02d.png", i)))
            texturesWalkLeft.append(SKTexture(imageNamed: String(format: "walking-left-%d.png", i)))
        }
        
        if let scene = scene as? GameScene2 {
            let leWildInteger = scene.mapNode.lowest
        }
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock({
                
                if self.frame.midy < leWildInteger {
                    self.scene?.view?.presentScene(GameOverScene(self.scene))
                }
            })
            ])))
    }
    
    func constrainMovement() {
        let mapNode = parent as! MapNode
        constraints = [SKConstraint.positionX(SKRange(lowerLimit: CGFloat(mapNode.startMap) + size.width / 2,
            upperLimit: CGFloat(mapNode.endMap) - size.width / 2))]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stop(){
        removeActionForKey("heroRun")
    }
    
    var movement: SKAction!
    
    // Methods
    func moveInDirection(direction: MovementDirection) {
        var movement: SKAction
        switch (direction) {
        case .Right:    movement = SKAction.moveBy(CGVector(dx: 3, dy: 0), duration: 0.01)
        case .Left:     movement = SKAction.moveBy(CGVector(dx: -3, dy: 0), duration: 0.01)
        default:        movement = SKAction()
        }
        
        
        runAction(SKAction.group([SKAction.repeatActionForever(movement), animationWalkingInDirection(direction)]), withKey: "heroRun")
    }
    
    func jump(){
        if footing > 0 {
            physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        }
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
        return SKAction.repeatActionForever(animation)
       
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == Mask.HERO && contact.bodyB.categoryBitMask == Mask.GROUND{
            footing++
        } else if contact.bodyB.categoryBitMask == Mask.HERO && contact.bodyA.categoryBitMask == Mask.GROUND{
            footing++
        }
        
        
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
            var slot = InventorySlot(hero: self, size: CGSize(width: 40, height: 25), color: SKColor.whiteColor(), title: "", onActionBegan: nil, onActionEnded: nil)
            scene.addChild(slot)
            slot.setItem(pickedUpItem)
            inventorySlots.append(slot)
            slot.position = CGPoint(x: CGFloat((inventorySlots.count-1) * 60 + 20), y: scene.frame.height - 50)
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == Mask.HERO && contact.bodyB.categoryBitMask == Mask.GROUND{
            footing--
        } else if contact.bodyB.categoryBitMask == Mask.HERO && contact.bodyA.categoryBitMask == Mask.GROUND{
            footing--
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let scene = scene as? GameScene2 {
            if let item = scene.heroNode.activatedItem {
                item.cast(self)
            }
        }
    }
}