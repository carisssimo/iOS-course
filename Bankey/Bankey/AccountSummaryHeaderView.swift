//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by simonecaria on 05/02/25.
//

import Foundation
import UIKit

class AccountSummaryHeaderView : UIView {
    
    @IBOutlet var contentView: UIView!
    
    let shakeyBellView = ShakeyBellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupShakeyBell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 160)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupShakeyBell() {
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBellView)
        
        NSLayoutConstraint.activate([
            shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shakeyBellView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
