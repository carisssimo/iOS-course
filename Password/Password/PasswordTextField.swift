//
//  PasswordTextField.swift
//  Password
//
//  Created by simonecaria on 20/02/25.
//


import UIKit

protocol PasswordTextFieldDelegate : AnyObject {
    func editingChanged(sender: PasswordTextField)
    func editingDidEnd(sender: PasswordTextField)
}

class PasswordTextField: UIView {
    
    typealias CustomValidation = (_ textValue : String?) -> (Bool, String)?
    
    let lockimageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    
    lazy var textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        return textField
    }()
    
    lazy var eyeButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage( UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let dividerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    lazy var errorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 16)
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.isHidden = true
        label.text = "Enter your password"
        return label
    }()
    
    
    var placeHolderText : String
    
    weak var delegate : PasswordTextFieldDelegate?
    
    var customValidation : CustomValidation?
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    init(placeHolderText: String) {
        
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemOrange
        
        lockimageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    func layout() {
        
        addSubview(lockimageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            
            lockimageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockimageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockimageView.trailingAnchor, multiplier: 1),
            
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor,multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor ),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        lockimageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

//MARK: Actions
extension  PasswordTextField {
    @objc private func eyeButtonTapped(){
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(sender: UITextField){
        delegate?.editingChanged(sender: self)
    }
}

//MARK: textFieldDelegate
extension PasswordTextField :  UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//MARK: Validation
extension PasswordTextField {
    
    func validate() -> Bool {
        if let customValidation = customValidation,
           let customValidationResult = customValidation(text ?? ""),
           customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
