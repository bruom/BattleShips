//
//  ConfirmViewController.swift
//  BattleShips
//
//  Created by Lucas Leal Mendonça on 23/05/15.
//  Copyright (c) 2015 Bruno Omella. All rights reserved.
//

import UIKit
import AVFoundation

class ConfirmViewController: UIViewController {

    var possibleTam : Int?
    var tamFala : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(possibleTam == 0){
            tamFala = "6 por 6";
        } else if (possibleTam == 1){
            tamFala = "8 por 8";
        } else {
            tamFala = "10 por 10";
        }
        
        let synthesizer = AVSpeechSynthesizer()
        
        let utterance2 = AVSpeechUtterance(string: "Você tem certeza que deseja escolher o tabuleiro \(tamFala!)? Toque na parte superior para confirmar, ou na inferior para retornar.");
        utterance2.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance2.rate = 0.1
        synthesizer.speakUtterance(utterance2)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func go(sender: AnyObject) {
        let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView") as! GameViewController
        gameView.gameType = possibleTam!
        self.presentViewController(gameView, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
