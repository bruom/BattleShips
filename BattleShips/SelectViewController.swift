//
//  SelectViewController.swift
//  BattleShips
//
//  Created by Lucas Leal Mendonça on 23/05/15.
//  Copyright (c) 2015 Bruno Omella. All rights reserved.
//

import AVFoundation
import UIKit

class SelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let synthesizer = AVSpeechSynthesizer()
        
        let utterance2 = AVSpeechUtterance(string: "Selecione o tamanho do tabuleiro entre três opções:");
        utterance2.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance2.rate = 0.1
        synthesizer.speakUtterance(utterance2)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! ConfirmViewController;
        vc.possibleTam = sender!.tag;
        
    }

}
