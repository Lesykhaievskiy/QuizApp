//
//  titleLabel.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 12.04.2024.
//

import UIKit

class titleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        self.textAlignment = alignment
        configure()
    }
    
    
    private func configure() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byWordWrapping 
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
