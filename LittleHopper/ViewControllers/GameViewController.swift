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
    var level = 1
    var data = NSDictionary()
    var levelData = [String]()
    var round = 0
    var playerOriginX:CGFloat!
    var playerOriginY:CGFloat!
    @IBOutlet weak var jackImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerOriginX = jackImage.frame.origin.x
        playerOriginY = jackImage.frame.origin.y
        if let path = Bundle.main.path(forResource: "Levels", ofType: "plist") {
            data = NSDictionary(contentsOfFile: path)!
        }
        levelData = data.value(forKey: "Level1") as! [String]
        print(levelData)
        let images: [UIImage] = (1...10).map { return UIImage(named: "Jump_\($0)")! }
        UIView.animate(withDuration: 2.0, animations: {
            self.jackImage.animationImages = images
            self.jackImage.animationDuration = 2.0
            self.jackImage.animationRepeatCount = 1
            self.jackImage.startAnimating()
        })
        setGame()
    }
    
    func setGame(){
        print(jackImage.frame)
        p1.alpha = 1
        p2.alpha = 1
        p3.alpha = 1
        if round < 15 {
            p1.setTitle(levelData[round], for: UIControl.State.normal)
            p2.setTitle(levelData[round + 1], for: UIControl.State.normal)
            p3.setTitle(levelData[round + 2], for: UIControl.State.normal)
            let randomInt = Int.random(in: 1...3)
            if randomInt == 1 {
                PlayEnglish("Find the word \((p1.titleLabel?.text)!)")
            }else if randomInt == 2 {
                PlayEnglish("Find the word \((p2.titleLabel?.text)!)")
            }else{
                PlayEnglish("Find the word \((p3.titleLabel?.text)!)")
            }
            round = round + 3
        }else{
            jackImage.frame = CGRect(x: (self.view.frame.midX-(jackImage.frame.width/2)), y: (self.view.frame.midY - (jackImage.frame.height/2)), width: jackImage.frame.width, height: jackImage.frame.height)
            
            self.performSegue(withIdentifier: "win", sender: nil)
        }
    }
    
    @IBAction func targetTouchAction(_ sender: Any) {
       // jackImage.frame = self.playerOriginalframe
        let images: [UIImage] = (1...10).map { return UIImage(named: "Jump_\($0)")! }
        UIView.animate(withDuration: 2.0, animations: {
                    self.jackImage.animationImages = images
                    self.jackImage.animationDuration = 2.0
                    self.jackImage.animationRepeatCount = 1
                    self.jackImage.startAnimating()
        }) { (Bool) in
            UIView.animate(withDuration: 2.0, animations: {
                self.jackImage.frame.origin.y = self.jackImage.frame.origin.y + (sender as! UIButton).frame.origin.y + 90.0
                self.jackImage.frame.origin.x = (sender as! UIButton).frame.origin.x + 40
                (sender as! UIButton).alpha = 0
            }){ (Bool) in
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (Timer) in
                    self.jackImage.frame.origin.x = self.playerOriginX
                    self.jackImage.frame.origin.y = self.playerOriginY
                    self.setGame()
                }
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        
        print("location touched \(location)")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
