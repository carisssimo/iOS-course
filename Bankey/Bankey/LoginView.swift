//
//  LoginView.swift
//  Bankey
//
//  Created by simonecaria on 29/01/25.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    private func layout() {
        
        let stackView = makeStackView(withOriantation: .vertical)
        usernameTextField = makeTextView(withText: "Username")
        let dividerView = makeDividerView()
        passwordTextField = makeTextView(withText: "Password")
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),

            
            
        ])
    }
    
    func makeTextView(withText text: String) -> UITextField{
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.placeholder = text
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.backgroundColor = .lightGray
//        textView.layer.cornerRadius = 5
//        textView.clipsToBounds = true
//        textView.layer.borderWidth = 2
        return textView
    }
    
    func makeStackView(withOriantation orientation: NSLayoutConstraint.Axis ) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = orientation
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }
    
    func makeDividerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
    
    
}

extension LoginView :  UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
