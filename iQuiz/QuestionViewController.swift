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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizQuestions = UIApplication.shared.quizQuestionRepository.getQuizQuestions()
        quizQuestion = quizQuestions?[quizProcess]
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func swipedLeft(_ gesture: UIGestureRecognizer) {
        goToHome()
    }
    
    @objc func swipedRight(_ gesture: UIGestureRecognizer) {
        goToAnswer()
    }
    
    @IBAction func asPressed(_ sender: UIButton) {
        selectedAnswer = (sender.titleLabel?.text)!
        if selectedAnswer == quizQuestion?.options[(quizQuestion?.answer)!] {
            quizQuestion?.correct = true
        }
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        UIApplication.shared.quizQuestionRepository.updateQuizQuestion(quizProcess, quizQuestion!)
        goToAnswer()
    }
    
    func goToHome() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToAnswer() {
        if selectedAnswer != "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerViewController
            vc.quizProcess = quizProcess
            vc.quizQuestion = quizQuestion
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
