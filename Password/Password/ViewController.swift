//
//  ViewController.swift
//  Password
//
//  Created by simonecaria on 20/02/25.
//

import UIKit

class ViewController : UIViewController {
    
    let passwordTextField = PasswordTextField(placeHolderText: "Nuova Password")
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Conferma Password")
    let passwordStatusView = PasswordStatusView()
    
    let resetButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("Reset Password", for: [])
        return button
    }()
    
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
        passwordStatusView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordStatusView.layer.cornerRadius = 5
        passwordStatusView.clipsToBounds = true
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordStatusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            //                        passwordTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor , multiplier: -1),
            //            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
}

