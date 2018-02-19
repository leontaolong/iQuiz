//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Leon T Long on 2/14/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    var quizQuestions: [QuizQuestion]? = nil
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    private var correct: Int = 0
    private var total: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizQuestions = UIApplication.shared.quizQuestionRepository.getQuizQuestions()
        getScore()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        scoreLabel.text = "\(correct) / \(total)"
        if Double(correct) / Double(total) > 0.8 {
            descLabel.text = "Perfect!"
        } else {
            descLabel.text = "Uh oh..."
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func swipedLeft(_ gesture: UIGestureRecognizer) {
        goToHome()
    }
    
    @objc func swipedRight(_ gesture: UIGestureRecognizer) {
        goToHome()
    }
    
    private func getScore() {
        total = (quizQuestions?.count)!
        correct = (quizQuestions?.filter{$0.correct}.count)!
    }
    @IBAction func backPressed(_ sender: UIButton) {
        goToHome()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        goToHome()
    }
    
    func goToHome() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
