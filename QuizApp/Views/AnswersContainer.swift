//
//  AnswersContainer.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 12.04.2024.
//
import UIKit

protocol AnswersContainerDelegate: AnyObject {
    func didTapNextButton()
}


class AnswersContainer: UIView {
    var quizManager: QuizManager
    var answers: [AnswerRow]
    var nextButton = NextButton(title: "Next")
    var ChooseLabel = BodyLabel(fontSize: 15)
    weak var delegate: AnswersContainerDelegate?
    
    init(frame: CGRect = .zero, quizManager: QuizManager, answers: [AnswerRow]) {
        self.quizManager = quizManager
        self.answers = answers
        super.init(frame: frame)
        configureChooseLabel()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureChooseLabel() {
        addSubview(ChooseLabel)
        ChooseLabel.text = "Choose the correct answer"
        
        NSLayoutConstraint.activate([
            ChooseLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            ChooseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            ChooseLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func tapped() {
        delegate?.didTapNextButton()
    }
    
    private func configure() {
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.shadowColor = backgroundColor?.cgColor
        addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)

        var previousAnswerBottomAnchor: NSLayoutYAxisAnchor = ChooseLabel.bottomAnchor
        for answer in answers {
            addSubview(answer)
            answer.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                answer.topAnchor.constraint(equalTo: previousAnswerBottomAnchor, constant: 15),
                answer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                answer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                answer.heightAnchor.constraint(equalToConstant: 50)
            ])
            previousAnswerBottomAnchor = answer.bottomAnchor
        }

        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: previousAnswerBottomAnchor, constant: 100),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        backgroundColor = UIColor(red: 9/255, green: 10/255, blue: 96/255, alpha: 1)
        layer.cornerRadius = 20
    }
}
