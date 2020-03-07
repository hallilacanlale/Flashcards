//
//  ViewController.swift
//  Flashcards!
//
//  Created by Halli  Lacanlale on 2/14/20.
//  Copyright © 2020 Halli Lacanlale. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}


class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        
        if (flashcards.count == 0) {
            updateFlashcard(question: "What is 111,111,111 x 111,111,111?", answer: "12,345,678,987,654,321")
        }
        
        else {
            updateLabels()
            updateNextPrevButtons()
        }
        
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btnOptionOne.layer.shadowRadius = 15.0
        btnOptionOne.layer.shadowOpacity = 0.2
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.180889219, green: 0.2373965383, blue: 0.4951084852, alpha: 1)
        
        btnOptionTwo.layer.shadowRadius = 15.0
        btnOptionTwo.layer.shadowOpacity = 0.2
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.180889219, green: 0.2373965383, blue: 0.4951084852, alpha: 1)
       
        btnOptionThree.layer.shadowRadius = 15.0
        btnOptionThree.layer.shadowOpacity = 0.2
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.180889219, green: 0.2373965383, blue: 0.4951084852, alpha: 1)


        // Do any additional setup after loading the view.
        card.clipsToBounds = true
        btnOptionOne.clipsToBounds = true
        btnOptionTwo.clipsToBounds = true
        btnOptionThree.clipsToBounds = true

    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontLabel.isHidden {
            frontLabel.isHidden = false
        }
        else{
            frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateNextPrevButtons(){
        
        if (currentIndex == flashcards.count - 1) {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        if (currentIndex == 0) {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{ (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print ("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
        
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        
        print("😎 Added new flashcard")
        print("😎 We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("😎 Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
    }
    
}

