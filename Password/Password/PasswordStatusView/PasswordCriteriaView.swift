//
//  PasswordCriteriaView.swift
//  Password
//
//  Created by simonecaria on 21/02/25.
//

import Foundation
import UIKit


class PasswordCriteriaView : UIView {
    
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = circleImage
        return imageView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 10)
    }
    
    init(text : String ) {
        super.init(frame: .zero)
        
        self.label.text = text
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCriteriaMet : Bool = false {
        didSet {
            if isCriteriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }
    
    func reset() {
        isCriteriaMet = false
        imageView.image = circleImage
    }
    
    private func setup() {
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    
}
