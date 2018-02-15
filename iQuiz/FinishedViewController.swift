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
        
        scoreLabel.text = "\(correct) / \(total)"
        if Double(correct) / Double(total) > 0.8 {
            descLabel.text = "Perfect!"
        } else {
            descLabel.text = "Uh oh..."
        }
        
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
