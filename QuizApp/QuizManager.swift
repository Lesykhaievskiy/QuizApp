//
//  QuizManager.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 13.04.2024.
//

import Foundation
import UIKit


class QuizManager: ObservableObject {
    private(set) var quiz: [Quiz.Result] = []
    @Published private(set) var length = 0
    var answerSelected = false
    @Published private(set) var question: String = ""
    @Published private(set) var answesChoices: [Answer] = []
    @Published private(set) var score = 0
    var index = 1
    var reachedEnd = false
    var progress: CGFloat = 0.00
    
    func fetchQuiz() async {
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard response == response else { fatalError("Error while fetching data") }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(Quiz.self, from: data)
            DispatchQueue.main.async {
                self.quiz = decodedData.results
                self.length = self.quiz.count
                self.setQuestion()
                
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    
    func selectAnswer(answer: Answer) {
        self.answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
                                    
    
    func goToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
            
        } else {
            reachedEnd = true
        }
    }
    

    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 300)
        
        if index < length {
            let currentQuestion = quiz[index]
            question = currentQuestion.question
            answesChoices = currentQuestion.answers
        }
    }
    
}
