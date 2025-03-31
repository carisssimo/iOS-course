//
//  TestViewController.swift
//  Bankey
//
//  Created by simonecaria on 26/03/25.
//

import Foundation
import UIKit

class TestViewController : UIViewController {
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    lazy var labelTest1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "labelTest1"
        label.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle)
        
        return label
    }()
    
    lazy var labelTest2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "labelTest2"
        label.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle2)
        
        return label
    }()
    
    lazy var stackview : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(stackview)
        stackview.addArrangedSubview(labelTest1)
        stackview.addArrangedSubview(labelTest2)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        
        
    }
}

