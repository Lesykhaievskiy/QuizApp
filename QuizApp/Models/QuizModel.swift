//
//  QuizModel.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 13.04.2024.
//

import Foundation


struct Quiz: Decodable {
    var results: [Result]
    
    
    
    struct Result: Decodable, Identifiable {
        var id: UUID { UUID() }
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        
        var formattedQuestion: AttributedString {
            do {
                return try AttributedString(markdown: question)
            } catch {
                print("Error setting formatted question: \(error) ")
                return ""
            }
        }
        
        var answers: [Answer] {
                let correct = [Answer(text: correctAnswer, isCorrect: true)]
                
                let incorrects =  incorrectAnswers.map { answer in
                    Answer(text:  answer, isCorrect: false)
                }
                
                let AllAnswers = correct + incorrects
                return AllAnswers.shuffled()
                
             
        }
        
    }
}
