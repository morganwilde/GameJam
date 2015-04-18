//
//  InventorySlot.swift
//  GameJam
//
//  Created by Arūnas Seniucas on 4/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class InventorySlot: ControlNode {
    
    var active = false
    var slottedItem: Item?
    var champion: HeroNode?
    
    init(hero: HeroNode, size: CGSize, color: UIColor, title: String, onActionBegan: (() -> ())?, onActionEnded: (() -> ())?){
        super.init(size: size, color: color, title: title, onActionBegan: onActionBegan, onActionEnded: onActionEnded)
        
        champion = hero
        alpha = 0.3
    }
    
    func setItem(offeredItem: Item){
        active = true
        slottedItem = offeredItem
        texture = offeredItem.texture
        alpha = 0.3
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        //println("Is currently selected: \(slottedItem == champion!.activatedItem)")
        
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if slottedItem == champion!.activatedItem{
            champion!.activatedItem = nil;
            alpha = 0.3
        }
        else if champion!.activatedItem == nil {
            champion!.activatedItem = slottedItem
            alpha = 1
        }
        else{
            champion!.getSelectedSlot()?.alpha = 0.3
            champion!.activatedItem = slottedItem
            alpha = 1
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
