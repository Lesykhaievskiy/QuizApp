//
//  BodyLabel.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 13.04.2024.
//

import UIKit

class BodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        self.textAlignment = .center
        configure()
    }
    
    
    private func configure() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        numberOfLines = 2
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
