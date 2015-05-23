//
//  ShipNode.swift
//  BattleShips
//
//  Created by Bruno Omella Mainieri on 5/19/15.
//  Copyright (c) 2015 Bruno Omella. All rights reserved.
//

import SpriteKit
import AVFoundation

class ShipNode:BSNode {
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var type:String!
    
    init(texture:SKTexture, type:String, tam:CGFloat){
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.size = CGSizeMake(tam, tam)
        self.type = type
        fala = "Acertou um \(type)"
    }
    
    override func beHit() {
        self.texture = SKTexture(imageNamed: "ship2")
        let hitAction = SKAction.playSoundFileNamed("Explosion.mp3", waitForCompletion: false)
        let waitAction = SKAction.waitForDuration(2)
        self.runAction(SKAction.sequence([waitAction, hitAction, waitAction]), completion: { () -> Void in
            let synthesizer = AVSpeechSynthesizer()
            
            let utterance = AVSpeechUtterance(string: self.fala)
            utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
            utterance.rate = 0.05
            synthesizer.speakUtterance(utterance)
            self.gotHit()
        })
        
    }
}
