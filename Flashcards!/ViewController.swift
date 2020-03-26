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
    
    var extraAnswerOne: String
    var extraAnswerTwo: String
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
    
    var correctAnswerButton: UIButton!
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        
        if (flashcards.count == 0) {
            updateFlashcard(question: "What is 111,111,111 x 111,111,111?", answer: "12,345,678,987,654,321", extraAnswerOne: "121,121,121,121,121,121", extraAnswerTwo: "98,765,432,123,456,789", isExisting: false)
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
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        btnOptionTwo.layer.shadowRadius = 15.0
        btnOptionTwo.layer.shadowOpacity = 0.2
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
       
        btnOptionThree.layer.shadowRadius = 15.0
        btnOptionThree.layer.shadowOpacity = 0.2
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)


        // Do any additional setup after loading the view.
        card.clipsToBounds = true
        btnOptionOne.clipsToBounds = true
        btnOptionTwo.clipsToBounds = true
        btnOptionThree.clipsToBounds = true

    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        if btnOptionOne == correctAnswerButton{
            flipFlashcard()
        }
        
        else{
            frontLabel.isHidden = false
            btnOptionOne.isEnabled = false
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo == correctAnswerButton{
            flipFlashcard()
        }
        
        else{
            frontLabel.isHidden = false
            btnOptionTwo.isEnabled = false
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree == correctAnswerButton{
            flipFlashcard()
        }
        
        else{
            frontLabel.isHidden = false
            btnOptionThree.isEnabled = false
        }
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        if flashcards.count <= 1 {
            // show alert "cannot delete last card!"
            let alert = UIAlertController(title: "Delete Flashcard", message: "You cannot delete the last remaining flashcard!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {action in
                self.deleteCurrentFlashcard()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            present(alert, animated: true)
        }
        
        
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        animateCardIn()
        updateNextPrevButtons()

        btnOptionOne.isEnabled = true
        btnOptionTwo.isEnabled = true
        btnOptionThree.isEnabled = true
        frontLabel.isHidden = false
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        animateCardOut()
        updateNextPrevButtons()

        btnOptionOne.isEnabled = true
        btnOptionTwo.isEnabled = true
        btnOptionThree.isEnabled = true
        frontLabel.isHidden = false
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.1, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: {finished in
            self.updateLabels()
            self.animateCardIn()})
    }
    
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func flipFlashcard(){
        if frontLabel.isHidden{
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.frontLabel.isHidden = false})
        }
            
        else{
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.frontLabel.isHidden = true})
        }
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        if (currentIndex > flashcards.count - 1){
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
   
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer

        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraAnswerOne, currentFlashcard.extraAnswerTwo].shuffled()
        
        
        for (button, answer) in zip(buttons, answers){
            button?.setTitle(answer, for: .normal)
            
            if answer == currentFlashcard.answer{
                correctAnswerButton = button
            }
        }
        
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
            return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print ("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
        
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo)
        
//        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
//        btnOptionTwo.setTitle(answer, for: .normal)
//        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
//
        
        if isExisting{
            flashcards[currentIndex] = flashcard
        }
            
        else {
            flashcards.append(flashcard)
            
            print("😎 Added new flashcard")
            print("😎 We now have \(flashcards.count) flashcards")
            
            currentIndex = flashcards.count - 1
            print("😎 Our current index is \(currentIndex)")
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "editSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialExtraOptionOne = btnOptionOne.currentTitle
            creationController.initialExtraOptionTwo = btnOptionThree.currentTitle
        } else if segue.identifier == "createSegue" {
            // user clicked on the Plus button
            
        }

    }
    
}

