//
//  QuestionVC.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 12.04.2024.
//

import UIKit

class QuestionVC: UIViewController {
    let quizManager = QuizManager()
    var question = titleLabel(fontSize: 30, alignment: .center)
    var answers: [AnswerRow] = []
    var answerContainer: AnswersContainer!
    var progressBar = ProgressBar(progress: 0)
    var numOfQuestions = titleLabel(fontSize: 20, alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         fetchQuiz()
    }
    
    
    private func fetchQuiz() {
        Task {
            await quizManager.fetchQuiz()
            DispatchQueue.main.async {
                for answer in self.quizManager.answesChoices {
                    self.answers.append(AnswerRow(answer: answer, quizManager: self.quizManager))
                }
                self.answerContainer = AnswersContainer(quizManager: self.quizManager, answers: self.answers)
                self.answerContainer.delegate = self
                self.configureBackgroundGradient()
                self.configureProgressBar()
                self.configureNumOfQuestions()
                self.configureQuestionTitle()
                self.configureAnswersContainer()
               
            }
        }
    }
    
    
    private func configureBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        let purple = UIColor(red: 207/255, green: 131/255, blue: 215/255, alpha: 1).cgColor
        let pink = UIColor(red: 230/255, green: 120/255, blue: 169/255, alpha: 1).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [purple, pink]
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    

    private func configureAnswersContainer() {
        view.addSubview(answerContainer)
        answerContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerContainer.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 15),
            answerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            answerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    func updateQuestionTitle() {
            self.question.text = quizManager.question
        }
    
    
    private func configureNumOfQuestions() {
        numOfQuestions.text = "\(quizManager.index)/\(quizManager.length)"
        view.addSubview(numOfQuestions)
        print(quizManager.index)
        NSLayoutConstraint.activate([
            numOfQuestions.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 10),
            numOfQuestions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numOfQuestions.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    private func configureProgressBar() {
        view.addSubview(progressBar)
        progressBar.progress = quizManager.progress
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            progressBar.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    
    private func configureQuestionTitle() {
        view.addSubview(question)
        question.text = quizManager.question
        
        NSLayoutConstraint.activate([
            question.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            question.topAnchor.constraint(equalTo: numOfQuestions.bottomAnchor),
            question.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            question.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}


extension QuestionVC: AnswersContainerDelegate {
    
    func didTapNextButton() {
        quizManager.goToNextQuestion()

        DispatchQueue.main.async {
            guard self.quizManager.index <= self.quizManager.length else {
                return
            }
            self.numOfQuestions.text = "\(self.quizManager.index)/\(self.quizManager.length)"

            
            self.updateQuestionTitle()
            self.progressBar.progress = self.quizManager.progress / 300

            self.answers = self.quizManager.answesChoices.map { AnswerRow(answer: $0, quizManager: self.quizManager) }

            self.answerContainer.removeFromSuperview()
            self.answerContainer = AnswersContainer(quizManager: self.quizManager, answers: self.answers)
            self.answerContainer.delegate = self
            self.configureAnswersContainer()
        }
    }


}


