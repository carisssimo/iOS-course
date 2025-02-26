//
//  ViewController.swift
//  Password
//
//  Created by simonecaria on 20/02/25.
//

import UIKit

class ViewController : UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
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
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
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
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    private func setupNewPassword(){
        let newPasswordValidation : CustomValidation = { text in
            
            //Empty text
            guard let text = text , !text.isEmpty else{
                self.passwordStatusView.reset()
                return (false,"Enter your password")
            }
            
            //Criteria met
            self.passwordStatusView.updateDisplay(text)
            if !self.passwordStatusView.validate(text){
                return (false,"Your Password must meet the requirements below")
            }
            
            return (true, "")
        }
        
        passwordTextField.customValidation = newPasswordValidation
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }
            
            guard text == self.passwordTextField.text else {
                return (false, "Passwords do not match.")
            }
            
            return (true, "")
        }
        
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}

extension ViewController : PasswordTextFieldDelegate {

    
    func editingChanged(sender: PasswordTextField) {
        if sender == passwordTextField {
            passwordStatusView.updateDisplay(sender.textField.text ?? "")

        }
    }
    
    func editingDidEnd(sender: PasswordTextField) {
        if sender === passwordTextField {
            // as soon as we lose focus, make ❌ appear
            passwordStatusView.shouldResetCriteria = false
            _ = passwordTextField.validate()
        } else if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
    
}

//MARK: KeyBoard
extension ViewController {
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField  = UIResponder.currentFirst() as? UITextField else { return }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
