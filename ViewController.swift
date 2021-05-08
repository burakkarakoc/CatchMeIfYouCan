//
//  ViewController.swift
//  OwnTrial
//
//  Created by Burak Karakoç on 20.04.2020.
//  Copyright © 2020 Burak Karakoç. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var highScore = 0
    var score = 0
    var timer = Timer()
    var hider = Timer()
    var timeCounter : Int = 10
    var gonzalezArray = [UIImageView]()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var gonzalez1: UIImageView!
    @IBOutlet weak var gonzalez2: UIImageView!
    @IBOutlet weak var gonzalez3: UIImageView!
    @IBOutlet weak var gonzalez4: UIImageView!
    @IBOutlet weak var gonzalez5: UIImageView!
    @IBOutlet weak var gonzalez6: UIImageView!
    @IBOutlet weak var gonzalez7: UIImageView!
    @IBOutlet weak var gonzalez8: UIImageView!
    @IBOutlet weak var gonzalez9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHS = UserDefaults.standard.object(forKey: "HS")
        if storedHS == nil {
            highScore = 0
            highestScoreLabel.text = "High score: \(highScore)"
        }
        if let newScore = storedHS as? Int {
            highScore = newScore
            highestScoreLabel.text = "High score: \(highScore)"
        }
        
        timeCounter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        hider = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hide), userInfo: nil, repeats: true)
        gonzalezArray = [gonzalez1,gonzalez2,gonzalez3,gonzalez4,gonzalez5,gonzalez6,gonzalez7,gonzalez8,gonzalez9]
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(gesture))
        
        gonzalez1.addGestureRecognizer(gestureRecognizer1)
        gonzalez2.addGestureRecognizer(gestureRecognizer2)
        gonzalez3.addGestureRecognizer(gestureRecognizer3)
        gonzalez4.addGestureRecognizer(gestureRecognizer4)
        gonzalez5.addGestureRecognizer(gestureRecognizer5)
        gonzalez6.addGestureRecognizer(gestureRecognizer6)
        gonzalez7.addGestureRecognizer(gestureRecognizer7)
        gonzalez8.addGestureRecognizer(gestureRecognizer8)
        gonzalez9.addGestureRecognizer(gestureRecognizer9)
        
        gonzalez1.isUserInteractionEnabled = true
        gonzalez2.isUserInteractionEnabled = true
        gonzalez3.isUserInteractionEnabled = true
        gonzalez4.isUserInteractionEnabled = true
        gonzalez5.isUserInteractionEnabled = true
        gonzalez6.isUserInteractionEnabled = true
        gonzalez7.isUserInteractionEnabled = true
        gonzalez8.isUserInteractionEnabled = true
        gonzalez9.isUserInteractionEnabled = true
        
        
        
    }
    @objc func gesture() {
        score += 1
        currentScoreLabel.text = "Current Score: \(score)"
    }
    @objc func time() {
        timeCounter -= 1
        timeLabel.text = "Time: \(timeCounter)"
        if timeCounter == 0 {
            timer.invalidate()
            hider.invalidate()
            timeLabel.text = "Time is over!"
            for x in gonzalezArray {
                x.isHidden = true
            }
            congratsLabel.text = "Congragulations!!"
            
            if score > highScore {
                highScore = score
                highestScoreLabel.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(highScore , forKey: "HS")
            }
            
            let alert = UIAlertController(title: "Time is up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                self.score = 0
                self.currentScoreLabel.text = "Current Score:"
                self.timeCounter = 10
                self.congratsLabel.text = "Catch it!!"
                
            }
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.currentScoreLabel.text = "Current Score: \(self.score)"
                self.timeCounter = 10
                self.timeLabel.text = "Time: \(self.timeCounter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.time), userInfo: nil, repeats: true)
                self.hider = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hide), userInfo: nil, repeats: true)
            }
            alert.addAction(yesButton)
            alert.addAction(noButton)
            self.present(alert,animated: true)
        }
    }
    @objc func hide() {
        for i in gonzalezArray {
            i.isHidden = true
        }
        let randomPicNum = Int(arc4random_uniform(UInt32 (gonzalezArray.count-1)))
        gonzalezArray[randomPicNum].isHidden = false
        if timeCounter == 0 {
            hider.invalidate()
        }
    }
}

