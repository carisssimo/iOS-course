//
//  ViewController.swift
//  Bankey
//
//  Created by simonecaria on 29/01/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    lazy var signInButton = makeButton(title: "Sign In")
    lazy var errorLabel = makeErrorLabel()
    lazy var titleLabel = makeBoldLabel(withText: "Bankey", ofSize: 32)
    lazy var subtitleLabel = makeBoldLabel(withText: "Your premium source for all things banking!", ofSize: 21)
    
    var username : String? {
        return loginView.usernameTextField.text
    }
    
    var password : String? {
        return loginView.passwordTextField.text
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    



}

extension LoginViewController {
    private func setupViews(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
    
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorLabel)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor ,constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor ,constant: -16),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 16),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            errorLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
        ])
    }
    
}

//MARK: factory methods
extension LoginViewController {
    func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle( title, for: [])
        button.configuration = .filled()
        button.configuration?.imagePadding = 8
        button.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        return button
        
    }
    
    func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "error failure"
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }
    
    func makeBoldLabel(withText text : String, ofSize : CGFloat) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: ofSize)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }
}


//MARK: logic
extension LoginViewController {
    @objc func signInTapped() {
        errorLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("username or password never been nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(with: "Username / password cannot be blank")
        }
        
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(with: "Incorrect username or password")
        }
        
    }
    
    private func configureView(with text: String){
        errorLabel.isHidden = false
        errorLabel.text = text
    }
    
    
}

