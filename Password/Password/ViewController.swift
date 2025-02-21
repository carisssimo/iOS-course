//
//  ViewController.swift
//  Password
//
//  Created by simonecaria on 20/02/25.
//

import UIKit

class ViewController : UIViewController {
    
    let passwordTextField = PasswordTextField(placeHolderText: "Nuova Password")
    let passwordCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)" )
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackView)
//        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordCriteriaView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            //                        passwordTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor , multiplier: -1),
            //            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
}

