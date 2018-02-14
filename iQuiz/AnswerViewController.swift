//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Leon T Long on 2/14/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var quizQuestions: [QuizQuestion]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        quizQuestions = UIApplication.shared.quizQuestionRepository.getQuizQuestion()

        // Do any additional setup after loading the view.
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
