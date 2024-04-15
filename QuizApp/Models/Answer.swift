//
//  Answer.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 12.04.2024.
//

import Foundation


struct Answer: Identifiable {
    var id = UUID()
    var text: String
    var isCorrect: Bool
}
