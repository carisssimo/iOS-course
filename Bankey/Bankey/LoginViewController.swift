//
//  ViewController.swift
//  Bankey
//
//  Created by simonecaria on 29/01/25.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    lazy var signInButton = makeButton(title: "Sign In")
    lazy var errorLabel = makeErrorLabel()
    lazy var titleLabel = makeBoldLabel(withText: "Bankey", ofSize: 32)
    lazy var subtitleLabel = makeBoldLabel(withText: "Your premium source for all things banking!", ofSize: 21)
    
    weak var delegate : LoginViewControllerDelegate?
    
    var username : String? {
        return loginView.usernameTextField.text
    }
    
    var password : String? {
        return loginView.passwordTextField.text
    }
    
    var leadingEdgeOnScreen : CGFloat = 16
    var leadingEdgeOffScreen : CGFloat = -1000
    
    var titleLabelLeadingAnchor : NSLayoutConstraint?
    var subtitleLabelLeadingAnchor : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLabels()
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
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor ,constant: -16),
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
        
        titleLabelLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLabelLeadingAnchor?.isActive = true
        
        subtitleLabelLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLabelLeadingAnchor?.isActive = true
    }
    
}

//MARK: Factory methods
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


//MARK: Logic
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
            delegate?.didLogin()
        } else {
            configureView(with: "Incorrect username or password")
        }
        
    }
    
    private func configureView(with text: String){
        errorLabel.isHidden = false
        errorLabel.text = text
        shakeButton()
    }
    
    
}

//MARK: Animation
extension LoginViewController {
    private func animateLabels() {
        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.titleLabelLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.subtitleLabelLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        animator1.startAnimation()
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0,0.16,0.5,0.83,1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}
