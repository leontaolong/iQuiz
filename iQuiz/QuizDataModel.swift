//
//  QuizQuestion.swift
//  iQuiz
//
//  Created by Leon T Long on 2/13/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import Foundation
import UIKit

class QuizQuestion {
    var question: String
    var options: [String]
    var answer: Int
    var correct: Bool
    
    init(_ question: String, _ options: [String], _ answer: Int, _ correct: Bool) {
        self.question = question
        self.options = options
        self.answer = answer
        self.correct = correct
    }
}

class QuizCategory: Hashable {
    var imgName: String
    var title: String
    var desc: String
    
    init(_ imgName: String, _ title: String, _ desc: String) {
        self.imgName = imgName
        self.title = title
        self.desc = desc
    }
    
    var hashValue: Int {
        return title.hashValue ^ desc.hashValue &* 16777619
    }
    
    static func == (qc1: QuizCategory, qc2: QuizCategory) -> Bool {
        return qc1.title == qc2.title && qc1.desc == qc2.desc
    }
}

class QuizQuestionRepository {
    private var quizData:Dictionary<QuizCategory, [QuizQuestion]> = [:]
    private var category:QuizCategory? = nil
    
    private var quizQuestions: [QuizQuestion] = []
    
    static let shared = QuizQuestionRepository()
    
    func deserializaData() {
        if let jsonData = UserDefaults.standard.array(forKey: "quizData") {
        let json = jsonData as! [Dictionary<String, AnyObject>]
            for item in json {
                let category = QuizCategory(item["title"] as! String, item["title"] as! String, item["desc"] as! String)
                var questions:[QuizQuestion] = []
                let questionsData = (item["questions"] as! NSArray) as Array
                for questionData in questionsData {
                    var question = questionData as! Dictionary<String, Any>
                    let quizQustion = QuizQuestion(question["text"] as! String, question["answers"] as! [String], Int(question["answer"] as! String)!, false)
                    questions.append(quizQustion)
                }
                quizData[category] = questions
            }
        }
    }
    
    func getQuizCategories() -> [QuizCategory] {
        return Array(quizData.keys)
    }
    
    func setCategory(_ category: QuizCategory) {
        self.category = category
        quizQuestions = quizData[category]!
    }
    
    func getQuizQuestions() -> [QuizQuestion] {
        return quizData[category!]!
    }
    
    func getQuizQuestion(id: Int) -> QuizQuestion {
        return quizQuestions[id]
    }
    
    func deleteQuizQuestion(id: Int) {
    }
    
    func addQuizQuestion(_ quizQuestion: QuizQuestion) {
    }
    
    func updateQuizQuestion(_ index: Int, _ quizQuestion: QuizQuestion) {
        quizQuestions[index] = quizQuestion
    }
}
