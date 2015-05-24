//
//  WaterNode.swift
//  BattleShips
//
//  Created by Bruno Omella Mainieri on 5/19/15.
//  Copyright (c) 2015 Bruno Omella. All rights reserved.
//

import SpriteKit
import AVFoundation

class WaterNode:BSNode {
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(texture:SKTexture, tam:CGFloat){
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.size = CGSizeMake(tam, tam)
        fala = "Água!"
    }
    
    override func beHit() {
        let hitAction = SKAction.playSoundFileNamed("Water.mp3", waitForCompletion: false)
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
    
//    override func beHit() {
//        let synthesizer = AVSpeechSynthesizer()
//        
//        let utterance = AVSpeechUtterance(string: self.fala)
//        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
//        utterance.rate = 0.05
//        if (!wasHit){
//            let hitAction = SKAction.playSoundFileNamed("Water.mp3", waitForCompletion: false)
//            let waitAction = SKAction.waitForDuration(2)
//            self.runAction(SKAction.sequence([waitAction, hitAction, waitAction]), completion: { () -> Void in
//                synthesizer.speakUtterance(utterance)
//                self.gotHit()
//            })
//        } else {
//            synthesizer.speakUtterance(utterance)
//        }
//        
//        
//        
//    }
    
    
}
