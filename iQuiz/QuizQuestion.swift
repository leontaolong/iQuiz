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
    var answer: Int
    var correct: Bool
    
    init(_ question: String, _ options: [String], _ answer: Int, _ correct: Bool) {
        self.question = question
        self.options = options
        self.answer = answer
        self.correct = correct
    }
}

class QuizQuestionRepository {
    private var quizQuestions: [QuizQuestion] = [
        QuizQuestion("Question 1: How many people are on the planet Earth?", ["A. Answer", "B. Answer", "C. Answer", "D. Answer"], 2, false),
        QuizQuestion("Question 2: How many people are on the planet Moon?", ["A. Answer", "B. Answer", "C. Answer", "D. Answer"], 3, false)
    ]
    
    static let shared = QuizQuestionRepository()
    
    func getQuizQuestions() -> [QuizQuestion] {
        return quizQuestions
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
