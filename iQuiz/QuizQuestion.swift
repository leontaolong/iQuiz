//
//  QuizQuestion.swift
//  iQuiz
//
//  Created by Leon T Long on 2/13/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import Foundation

class QuizQuestion {
    var question: String
    var options: [String]
    var answer: String
    var correct: Bool
    
    init(_ question: String, _ options: [String], _ answer: String, _ correct: Bool) {
        self.question = question
        self.options = options
        self.answer = answer
        self.correct = correct
    }
}

class QuizQuestionRepository {
    private let quizQuestions: [QuizQuestion] = [
        QuizQuestion("Question 1: How many people are on the planet Earth?", ["A. Answer", "B. Answer", "C. Answer", "D. Answer"], "A. Answer", false),
        QuizQuestion("Question 2: How many people are on the planet Moon?", ["A. Answer", "B. Answer", "C. Answer", "D. Answer"], "A. Answer", false)
    ]
    
    static let shared = QuizQuestionRepository()
    
    func getQuizQuestion() -> [QuizQuestion] {
        return quizQuestions
    }
    func getQuizQuestion(id: Int) -> QuizQuestion {
        return quizQuestions[id]
    }
    
    func deleteQuizQuestion(id: Int) {
        // remove from the array
    }
    
    func addQuizQuestion(name: QuizQuestion) {
        // add to the array
    }
    
    func updateQuizQuestion(name: QuizQuestion) {
        // send the update back to the server
    }
}
