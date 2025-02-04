//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by simonecaria on 31/01/25.
//

import Foundation
import UIKit

protocol OnBoardingViewControllerDelegate : AnyObject {
    func didTapNextButton()
    func didTapPrevButton()
}

class OnboardingViewController : UIViewController {
    
    weak var delegate :  OnBoardingViewControllerDelegate?
    
    let labeltext : String
    let imageName : String
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labeltext
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true 
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: imageName)
        
        return imageView
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: [])
        button.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
        button.setTitleColor(.systemBlue, for: [])
        return button
    }()
    
    lazy var previousButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Prev", for: [])
        button.addTarget(self, action: #selector(prevButtonTapped), for: .primaryActionTriggered)
        button.setTitleColor(.systemBlue, for: [])
        return button
    }()
    
    init(withImage imageName : String, withText text : String) {
        
        self.imageName = imageName
        self.labeltext = text
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews(){
        
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        view.addSubview(nextButton)
        view.addSubview(previousButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            previousButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
}

//MARK: action
extension OnboardingViewController {
    @objc func nextButtonTapped() {
        delegate?.didTapNextButton()
    }
    
    @objc func prevButtonTapped(){
        delegate?.didTapPrevButton()
    }
}
