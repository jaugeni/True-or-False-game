//
//  ViewController.swift
//  True or False
//
//  Created by YAUHENI IVANIUK on 2/16/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var trueBtnOutl: UIButton!
    @IBOutlet weak var falseBtnOutl: UIButton!
    
    var listOfQuestion = [String]()
    var listOfAnswers = [Bool]()
    var hasBeenAnswered = [Bool]()
    var currentQuestion = String()
    var currentAnswer = Bool()
    var score = 0
    var randemNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listOfQuestion = ["As far as has ever been reported, no-one has ever seen an ostrich bury its head in the sand.",
                          "Approximately one quarter of human bones are in the feet.",
                          "Popeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye.",
                          "In ancient Rome, a special room called a vomitorium was available for diners to purge food in during meals.",
                          "A slug’s blood is green.",
                          "Chewing gum takes seven years for a person to digest"
        ]
        
        listOfAnswers = [true, true, true, false, true, false]
        
        
        var i = 0
        repeat{
            hasBeenAnswered.append(false)
            i += 1
        } while (i < listOfQuestion.count)
        
        print(hasBeenAnswered)
        
    }
    
    @IBAction func truePrwssed(_ sender: Any) {
        if currentAnswer == true {
            score += 1
            scoreLbl.text = "Score: \(score)"
            createAlert(title: "Corret", message: "Your answer True is correct!")
        } else {
            createAlert(title: "Incorrect", message: "Correct answer in False")
        }
        
        initiateEndGame()
    }
    
    @IBAction func falsePressed(_ sender: Any) {
        if currentAnswer == true {
            score += 1
            scoreLbl.text = "Score: \(score)"
            createAlert(title: "Corret", message: "Your answer False is correct!")
        } else {
            createAlert(title: "Incorrect", message: "Correct answer in False")
        }
        
        initiateEndGame()
    }
    
    @IBAction func newGamePressed(_ sender: Any) {
        
        for index in 0..<hasBeenAnswered.count {
            hasBeenAnswered[index] = false
        }
        chooseQuestion()
        score = 0
        scoreLbl.text = "Score: \(score)"
        
        trueBtnOutl.isEnabled = true
        falseBtnOutl.isEnabled = true

    }
    
    func creatrRandomNumber() {
        randemNumber = Int(arc4random_uniform(UInt32(listOfQuestion.count)))
        if hasBeenAnswered[randemNumber] == true {
            creatrRandomNumber()
        }
        hasBeenAnswered[randemNumber] = true
    }
    
    func chooseQuestion() {
        creatrRandomNumber()
        currentQuestion = listOfQuestion[randemNumber]
        currentAnswer = listOfAnswers[randemNumber]
        questionLbl.text = currentQuestion
        
    }
    
    func checkIfOver() -> Bool {
        for index in 0..<hasBeenAnswered.count {
            if hasBeenAnswered[index] == false {
                return false
            }
        }
        return true
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated:  true, completion: nil)
    }
    
    func initiateEndGame() {
        if checkIfOver() == true {
            questionLbl.text = "Congratulation! Yor final score is:"
            scoreLbl.text = "\(score)"
            trueBtnOutl.isEnabled = false
            falseBtnOutl.isEnabled = false
        } else {
            chooseQuestion()
        }
    }
}

