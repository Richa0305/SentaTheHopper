//
//  GameViewController.swift
//  LittleHopper
//
//  Created by Richu on 08/12/18.
//  Copyright © 2018 Shivhari Inc. All rights reserved.
//

import UIKit
import Speech

class GameViewController: UIViewController, CAAnimationDelegate,AVSpeechSynthesizerDelegate {

    @IBOutlet weak var p3: UIButton!
    @IBOutlet weak var p2: UIButton!
    @IBOutlet weak var p1: UIButton!
    var synthesizer = AVSpeechSynthesizer()
    var totalUtterance : Int = 0
    
    @IBOutlet weak var jackImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PlayEnglish("Find the word She")
    }
    
    @IBAction func targetTouchAction(_ sender: Any) {
        let images: [UIImage] = (1...10).map { return UIImage(named: "Jump_\($0)")! }
        UIView.animate(withDuration: 0, animations: {
                    self.jackImage.animationImages = images
                    self.jackImage.animationDuration = 2.0
                    self.jackImage.animationRepeatCount = 1
                    self.jackImage.startAnimating()
        }) { (Bool) in
            UIView.animate(withDuration: 2.0, animations: {
                self.jackImage.frame.origin.y = self.jackImage.frame.origin.y + (sender as! UIButton).frame.origin.y + 40.0
                self.jackImage.frame.origin.x = (sender as! UIButton).frame.origin.x
                
            })
        }
    }
    func PlayEnglish(_ sender: String) {
        if !self.synthesizer.isSpeaking {
            let textPara = sender.components(separatedBy: "\n")
            self.totalUtterance = (textPara.count)
            for pieceOfText in textPara{
                let speechUtterance = AVSpeechUtterance(string: pieceOfText)
                let voice = AVSpeechSynthesisVoice(language: "en-GB");
                speechUtterance.voice = voice
                speechUtterance.rate = 0.5
                speechUtterance.pitchMultiplier = 2.0
                self.synthesizer.speak(speechUtterance)
            }
            
        }else{
            self.synthesizer.continueSpeaking()
        }
    }
    

}
