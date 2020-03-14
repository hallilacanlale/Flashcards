//
//  CreationViewController.swift
//  Flashcards!
//
//  Created by Halli  Lacanlale on 3/4/20.
//  Copyright © 2020 Halli Lacanlale. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialExtraOptionOne: String?
    var initialExtraOptionTwo: String?
    var isExisting = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        extraAnswerOneTextField.text = initialExtraOptionOne
        extraAnswerTwoTextField.text = initialExtraOptionTwo
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let extraAnswerOneText = extraAnswerOneTextField.text
        let extraAnswerTwoText = extraAnswerTwoTextField.text
        
        let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty || extraAnswerOneText == nil || extraAnswerTwoText == nil || extraAnswerOneText!.isEmpty || extraAnswerTwoText!.isEmpty){
            present(alert, animated: true)
        }
            
        else{
            if initialQuestion != nil{
                isExisting = true
            }
            
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!, isExisting: isExisting)
            dismiss(animated: true)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
