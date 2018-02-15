//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Leon T Long on 2/14/18.
//  Copyright © 2018 leontaolong. All rights reserved.
///Users/longt8/Desktop/iQuiz/iQuiz

import UIKit

class QuestionViewController: UIViewController {
    var quizQuestions: [QuizQuestion]? = nil
    var quizProcess: Int = 0
    var quizQuestion: QuizQuestion? = nil
    var selectedAnswer: String = ""

    @IBOutlet weak var as1: UIButton!
    @IBOutlet weak var as2: UIButton!
    @IBOutlet weak var as3: UIButton!
    @IBOutlet weak var as4: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizQuestions = UIApplication.shared.quizQuestionRepository.getQuizQuestions()
        print(quizProcess)
        quizQuestion = quizQuestions?[quizProcess]
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        questionLabel.text = quizQuestion?.question
        // Do any additional setup after loading the view.
    }
    

    @objc func swipedLeft(_ gesture: UIGestureRecognizer) {
        goToAnswer()
    }
    
    @objc func swipedRight(_ gesture: UIGestureRecognizer) {
        goToHome()
    }
    
    @IBAction func asPressed(_ sender: UIButton) {
        selectedAnswer = (sender.titleLabel?.text)!
        let options = [as1, as2, as3, as4]
        options.forEach{btn in btn?.backgroundColor = UIColor.darkGray}
        sender.backgroundColor = UIColor.blue
        
        if selectedAnswer == quizQuestion?.options[(quizQuestion?.answer)!] {
            quizQuestion?.correct = true
        } else {
            quizQuestion?.correct = false
        }
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        UIApplication.shared.quizQuestionRepository.updateQuizQuestion(quizProcess, quizQuestion!)
        goToAnswer()
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        goToHome()
    }
    
    func goToHome() {
        let alertController = UIAlertController(title: "Warming", message: "Are you sure that you want to quit the quiz and go back to Home?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let quitAction = UIAlertAction(title: "Quit", style: .destructive, handler: {(alert: UIAlertAction!) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: false)
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(quitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func goToAnswer() {
        
        if selectedAnswer == "" {
            let alertController = UIAlertController(title: "Warming", message: "You must select an answer to continue the quiz.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerViewController
            vc.quizProcess = quizProcess
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
