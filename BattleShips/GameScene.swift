//
//  GameScene.swift
//  BattleShips
//
//  Created by Bruno Omella Mainieri on 5/19/15.
//  Copyright (c) 2015 Bruno Omella. All rights reserved.
//

import AVFoundation
import SpriteKit

class GameScene: SKScene {
    
    var prevUpdate:Double = 0.0
    var lastTouch:Double = 10.0
    var tabuleiro:Tabuleiro!
    var tam:CGFloat = CGFloat(60)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        tabuleiro = Tabuleiro(x: 8, y: 8, tamanho: tam)
        tabuleiro.name = "tab"
        tabuleiro.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(8*tam, 8*tam))
        tabuleiro.physicsBody?.dynamic = false
        tabuleiro.position = CGPointMake(self.size.width/2 - tam * 8 / 2, self.size.height * 0.18)
        self.addChild(tabuleiro)
        
        self.allAgua()
        self.colocaNavios(self.sorteiaNavios(3))
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if lastTouch >= 2.5 {
            for touch in (touches as! Set<UITouch>) {
                let location = touch.locationInNode(self)
                let locationGrid = touch.locationInNode(self.tabuleiro)
                
                //if let body = physicsWorld.bodyAtPoint(location) {
                //if body.node!.name == "tab" {
                
                //buscando a letra pela posição do toque na grid, e nao no bodyAtPoint
                if let tilezinha = self.tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y){
                    
                    self.lastTouch = 0.0
                    
                    tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y)!.content?.alpha = 0.5
                    let nodinho = tilezinha.content
                    let synthesizer = AVSpeechSynthesizer()
                    
                    let utterance2 = AVSpeechUtterance(string: "\(tilezinha.x), \(tilezinha.y)")
                    utterance2.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                    utterance2.rate = 0.1
                    synthesizer.speakUtterance(utterance2)
                    
                    
                    let utterance = AVSpeechUtterance(string: nodinho?.fala)
                    utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                    utterance.rate = 0.05
                    synthesizer.speakUtterance(utterance)
                    
                    
                    
                    nodinho!.gotHit()
                }
                
                //}
                //}
            }
            
        }

        
//        let synthesizer = AVSpeechSynthesizer()
//        let utterance = AVSpeechUtterance(string: "Água")
//        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
//        utterance.rate = 0.05
//        synthesizer.speakUtterance(utterance)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var timeElapsed = currentTime - prevUpdate
        prevUpdate = currentTime
        lastTouch = lastTouch + timeElapsed
        
    }
    
    func allAgua() {
        for i in 0...self.tabuleiro.grid.columns-1 {
            for j in 0...self.tabuleiro.grid.rows-1 {
                let nodeAux = WaterNode(texture: SKTexture(imageNamed: "water"), tam: self.tam)
                tabuleiro.addBSNode(i, y: j, node: nodeAux)
            }
        }
    }
    
    func encheNodes(navios:NSArray) -> Array<BSNode> {
        var nodesFinal = Array<BSNode>()
        for i in 0...navios.count-1 {
            let navioAux = ShipNode(texture: SKTexture(imageNamed: "ship2"), type: "Submarine", tam: self.tam)
            nodesFinal.append(navioAux)
        }
        for i in 0...self.tabuleiro.grid.columns*self.tabuleiro.grid.rows-1 {
            tabuleiro.addBSNode(i/self.tabuleiro.grid.rows, y: i%self.tabuleiro.grid.rows, node: nodesFinal[i])
        }
        return nodesFinal
    }
    
    func sorteiaNavios(num:Int) -> NSMutableArray{
        var seed = NSMutableArray()
        var aux = num
        var flag = true
        while aux > 0 {
            flag = true
            let rX = arc4random_uniform(UInt32(self.tabuleiro.grid.rows-1))
            let rY = arc4random_uniform(UInt32(self.tabuleiro.grid.columns-1))
            let coord = NSArray(objects: Int(rX), Int(rY))
            for coisa in seed {
                let coisa2 = coisa as! NSArray
                if (coisa2 == coord){
                    flag = false
                }
            }
            if flag{
                seed.addObject(coord)
                aux--
            }
        }
        return seed
    }
    
    func colocaNavios(navios:NSMutableArray) {
        for coord in navios {
            let coord2 = coord as! NSArray
//            let tile:Tile = self.tabuleiro.tileForPos(coord2.firstObject as! Int, y: coord2.lastObject as! Int)!
//            tile.content?.removeFromParent()
//            tile.content = ShipNode(texture: SKTexture(imageNamed: "ship"), type: "Crusador", tam: self.tam)
            self.tabuleiro.updateBSNode(coord2.firstObject as! Int, y: coord2.lastObject as! Int, node: ShipNode(texture: SKTexture(imageNamed: "ship2"), type: "Crusador", tam: self.tam))
            
        }
    }
}
