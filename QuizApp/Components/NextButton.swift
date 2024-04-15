//
//  nextButton.swift
//  QuizApp
//
//  Created by Олексій Гаєвський on 12.04.2024.
//

import UIKit

class NextButton: UIButton {

    
    override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
      }
    
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      
      init(title: String) {
          super.init(frame: .zero)
          self.backgroundColor = UIColor(red: 238/255, green: 186/255, blue: 77/255, alpha: 1)
          self.setTitle(title, for: .normal)
          configure()
      }
      
      
      private func configure(){
          layer.cornerRadius = 25
          titleLabel?.textColor = .white
          titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
          translatesAutoresizingMaskIntoConstraints = false
      }
      
      
      func set(title: String) {
        setTitle(title, for: .normal)
      }

}
