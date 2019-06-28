//
//  ViewController.swift
//  cornholescore
//
//  Created by Bennett Schoonerman on 6/17/19.
//  Copyright © 2019 BennettSchoonerman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //state vars
    let pointsCancel = true
    
    //buttons
    @IBOutlet weak var onboard1: UIStepper!
    @IBOutlet weak var onboard2: UIStepper!
    @IBOutlet weak var inboard1: UIStepper!
    @IBOutlet weak var inboard2: UIStepper!
    @IBOutlet weak var nextButton: UIButton!
    
    //labels
    var team1Score = 0
    var team2Score = 0
    var previousScore1 = 0
    var previousScore2 = 0
    
    @IBOutlet weak var onLabel1: UILabel!
    @IBOutlet weak var onLabel2: UILabel!
    @IBOutlet weak var inLabel1: UILabel!
    @IBOutlet weak var inLabel2: UILabel!
    
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        onboard1.stepValue = 1
        onboard2.stepValue = 1
        inboard1.stepValue = 1
        inboard2.stepValue = 1
    }


    @IBAction func Stepper(_ sender: UIStepper) {
        //tags 0,2 are team 1 and tags 1,3 are team 2
        switch sender.tag {
        case 0:
            if(sender.value + inboard1.value > 4){
                sender.value -= 1
            }
        case 1:
            if(sender.value + inboard2.value > 4){
                sender.value -= 1
            }
        case 2:
            if(sender.value + onboard1.value > 4){
                sender.value -= 1
            }
        case 3:
            if(sender.value + onboard2.value > 4){
                sender.value -= 1
            }
        default:
            print("Unknown Sender Tag")
        }
        updateLabels()
    }
    
    
    @IBAction func nextRound(_ sender: Any) {
        print("next round pls")
        calculateScore()
        resetSteppers()
        updateScore()
        updateLabels()
    }
    
    //helpers
    
    func resetSteppers(){
        onboard1.value = 0
        onboard2.value = 0
        inboard1.value = 0
        inboard2.value = 0
    }
    
    func calculateScore(){
        var b1 = Int(onboard1.value)
        var i1 = Int(inboard1.value)
        
        var b2 = Int(onboard2.value)
        var i2 = Int(inboard2.value)
        
        if(pointsCancel){
            //on board cancelations
            if(b2 == b1){
                b1 = 0
                b2 = 0
            }
            if(b2 > b1){
                b2 = b2 - b1
                b1 = 0
            }
            if(b1 > b2){
                b1 = b1 - b2
                b2 = 0
            }
            //in board cancelations
            if(i1 == i2){
                i1 = 0
                i2 = 0
            }
            if(i2 > i1){
                i2 = i2 - i1
                i1 = 0
            }
            if(i1 > i2){
                i1 = i1 - i2
                i2 = 0
            }
            
        }
        previousScore1 = team1Score
        previousScore2 = team2Score
        team1Score += Int(b1 + (i1 * 3))
        team2Score += Int(b2 + (i2 * 3))
    }
    
    func updateLabels(){
        onLabel1.text = String(Int(onboard1.value))
        onLabel2.text = String(Int(onboard2.value))
        inLabel1.text = String(Int(inboard1.value))
        inLabel2.text = String(Int(inboard2.value))
    }
    
    func updateScore(){
        score1.text = String(team1Score)
        score2.text = String(team2Score)
    }
    
    func validateScores()->Bool{
        return true
    }
    @IBAction func revert(_ sender: Any) {
        let alert = UIAlertController(title: "Revert Score", message: "Are you sure you want to revert the score?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No 👎", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes 👍", style: .destructive, handler: { _ in
            self.resetSteppers()
            self.updateLabels()
            self.team1Score = self.previousScore1
            self.team2Score = self.previousScore2
            self.updateScore()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func NewGame(_ sender: Any) {
        let alert = UIAlertController(title: "New Game 🍻", message: "Are you sure you want to trash this game?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No 👎", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes 👍", style: .destructive, handler: { _ in
            self.resetSteppers()
            self.updateLabels()
            self.team1Score = 0
            self.team2Score = 0
            self.updateScore()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

