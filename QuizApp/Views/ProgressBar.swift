//
//  ProgressBar.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 14.04.2024.
//
import UIKit
class ProgressBar: UIView {
    var progress: CGFloat {
        didSet {
            updateProgressView()
        }
    }
    private let progressView = UIView()
    
    init(progress: CGFloat = 0.0, frame: CGRect = .zero) {
        self.progress = progress
        super.init(frame: frame)
        configure()
        updateProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor(red: 9/255, green: 10/255, blue: 96/255, alpha: 1)
        progressView.backgroundColor = UIColor(red: 238/255, green: 186/255, blue: 77/255, alpha: 1)
        layer.cornerRadius = 5
        progressView.layer.cornerRadius = 5
        
        addSubview(progressView)
    }
    
    private func updateProgressView() {
        let progressWidth = frame.width * progress 
        progressView.frame = CGRect(x: 0, y: 0, width: progressWidth, height: 10)
    }
}
