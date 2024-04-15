//
//  AnswerRow.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 12.04.2024.
//

import UIKit

class AnswerRow: UIView {
    let quizManager: QuizManager
    var answer: Answer
    var answerTextLable = titleLabel(fontSize: 20, alignment: .left)
    var isSelected: Bool = false
    
    init(answer: Answer, quizManager: QuizManager, frame: CGRect = .zero) {
            self.quizManager = quizManager
            self.answer = answer
            super.init(frame: frame)
            configure()
            setUpGesture()
        }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGestureRecognizer)
        isUserInteractionEnabled = true
    }
    
    
    @objc func tapped() {

        if !quizManager.answerSelected {
            isSelected = true
            quizManager.selectAnswer(answer: answer)
            configure()
        }
        
       
        
    }

    
    private func configure() {
        backgroundColor = isSelected ? (answer.isCorrect ? UIColor.green : UIColor.red) : UIColor(red: 49/255, green: 44/255, blue: 144/255, alpha: 1)
        layer.cornerRadius = 10
        layer.shadowColor = backgroundColor?.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 10
        addSubview(answerTextLable)
        translatesAutoresizingMaskIntoConstraints = false
        answerTextLable.text = answer.text
        
        NSLayoutConstraint.activate([
            answerTextLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            answerTextLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            answerTextLable.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
