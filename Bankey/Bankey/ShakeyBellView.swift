//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by simonecaria on 11/02/25.
//

import Foundation
import UIKit

class ShakeyBellView : UIView {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTapGesture()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white,renderingMode: .alwaysOriginal)
        imageView.image = image
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
            
        ])
    }
    
    func addTapGesture() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
    
    
}

extension ShakeyBellView {
    @objc private func imageViewTapped(){
        print("Shaking!!!")
    }
}
