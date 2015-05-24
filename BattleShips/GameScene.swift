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
    var desistir: SKSpriteNode!
    var tam:CGFloat = CGFloat(50)
    var type : Int?
    var navios : Int?
    var desistencia = false;
    var vc : GameViewController?
    var labelTamanho : SKLabelNode!;

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        labelTamanho = SKLabelNode();
        if(type == 0){
            tam = CGFloat(70);
            navios = 9;
            tabuleiro = Tabuleiro(x: 6, y: 6, tamanho: tam)
            tabuleiro.position = CGPointMake(self.size.width/2 - tam * 6 / 2, self.size.height * 0.35)
            labelTamanho.text = "6 x 6"
        } else if (type == 1){
            tam = CGFloat(50);
            navios = 16;
            tabuleiro = Tabuleiro(x: 8, y: 8, tamanho: tam)
            tabuleiro.position = CGPointMake(self.size.width/2 - tam * 8 / 2, self.size.height * 0.35)
            labelTamanho.text = "8 x 8"
        } else {
            tam = CGFloat(40);
            navios = 25;
            tabuleiro = Tabuleiro(x: 10, y: 10, tamanho: tam)
            tabuleiro.position = CGPointMake(self.size.width/2 - tam * 10 / 2, self.size.height * 0.35)
            labelTamanho.text = "10 x 10"
        }
        labelTamanho.fontColor = UIColor.blackColor();
        labelTamanho.fontSize = CGFloat(36.0);
        labelTamanho.position = CGPointMake(self.size.width/2, self.size.height*0.95);
        self.addChild(labelTamanho);
        
       // tabuleiro = Tabuleiro(x: 8, y: 8, tamanho: tam)
        tabuleiro.name = "tab"
        tabuleiro.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(8*tam, 8*tam))
        tabuleiro.physicsBody?.dynamic = false
//        tabuleiro.position = CGPointMake(self.size.width/2 - tam * 8 / 2, self.size.height * 0.18)
        self.addChild(tabuleiro)
        
        self.allAgua()
        self.colocaNavios(self.sorteiaNavios(navios!))
        
        //desistir = SKSpriteNode(texture: SKTexture(imageNamed: "DesistirIHC"));
        //desistir = SKSpriteNode(texture: SKTexture(imageNamed: "DesistirIHC"), size: 80);
        desistir = SKSpriteNode(imageNamed: "DesistirIHC.png");
        desistir.size = CGSizeMake(self.size.width * 0.70, self.size.height * 0.10);
        //desistir.frame.size = CGSizeMake(width: self.size.width, height: self.size.height * 0.10);
        desistir.name = "desistir";
        desistir.physicsBody = SKPhysicsBody(rectangleOfSize: desistir.size);
        desistir.physicsBody?.dynamic = false
        desistir.position = CGPointMake(self.size.width / 2, self.size.height * 0.05);
        self.addChild(desistir);
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if lastTouch >= 6.0 {
            for touch in (touches as! Set<UITouch>) {
                let location = touch.locationInNode(self)
                let locationGrid = touch.locationInNode(self.tabuleiro)
                if let body = physicsWorld.bodyAtPoint(location) {
                    if body.node!.name == "tab" {
                        //if let body = physicsWorld.bodyAtPoint(location) {
                        //if body.node!.name == "tab" {
                        
                        //buscando a letra pela posição do toque na grid, e nao no bodyAtPoint
                        if let tilezinha = self.tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y){
                            
                            self.lastTouch = 0.0
                            
                            tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y)!.content?.alpha = 0.5
                            let nodinho = tilezinha.content
                            let synthesizer = AVSpeechSynthesizer()
                            
                            let utterance2 = AVSpeechUtterance(string: falaSLQ(tilezinha.x, y: tilezinha.y));
                            utterance2.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                            utterance2.rate = 0.1
                            synthesizer.speakUtterance(utterance2)
                            
                            
                            
                            //                    let utterance = AVSpeechUtterance(string: nodinho?.fala)
                            //                    utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                            //                    utterance.rate = 0.05
                            //                    synthesizer.speakUtterance(utterance)
                            
                            nodinho!.beHit()
                            desistencia = false;
                        }
                        //nodinho!.gotHit()
                    } else if (body.node?.name == "desistir"){
                        if(desistencia){
                            self.vc!.performSegueWithIdentifier("Desistiu", sender: nil);
                            
                        } else {
                            desistencia = true;
                            let synthesizer = AVSpeechSynthesizer()
                            
                            let utterance2 = AVSpeechUtterance(string: "Você tem certeza que deseja desistir? Toque novamente na parte inferiror para confirmar.");
                            utterance2.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                            utterance2.rate = 0.1
                            synthesizer.speakUtterance(utterance2)
                        }
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
    }
    
    func falaSLQ(x: Int, y: Int) -> String{
        let posX = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];
        return "\(posX[x]), \(y + 1)"
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
            self.tabuleiro.updateBSNode(coord2.firstObject as! Int, y: coord2.lastObject as! Int, node: ShipNode(texture: SKTexture(imageNamed: "water"), type: "Crusador", tam: self.tam))
            
        }
    }
}
