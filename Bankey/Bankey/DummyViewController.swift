//
//  DummyViewController.swift
//  Bankey
//
//  Created by simonecaria on 03/02/25.
//

import UIKit

protocol DummyViewControllerDelegate : AnyObject{
    func didLogout()
}

class DummyViewController : UIViewController {
    
    weak var delegate : DummyViewControllerDelegate?
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    
        return label
    }()
    
    lazy var button : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

//MARK: actions
extension DummyViewController {
    @objc func logoutButtonTapped(){
        delegate?.didLogout()
    }
}
