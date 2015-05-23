//
//  BSNode.swift
//  BattleShips
//
//  Created by Bruno Omella Mainieri on 5/19/15.
//  Copyright (c) 2015 Bruno Omella. All rights reserved.
//

import SpriteKit

class BSNode:SKSpriteNode {
    
    var wasHit:Bool!
    
    var fala:String!
    
    func gotHit(){
        wasHit = true
        fala = "Voce já atirou aqui."
    }
    
}
