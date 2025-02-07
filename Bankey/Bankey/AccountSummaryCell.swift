//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by simonecaria on 05/02/25.
//

import Foundation
import UIKit

class  AccountSummaryCell : UITableViewCell {
    
    enum AccountType : String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accountType : AccountType
        let accountName : String
        let balance : Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight : CGFloat = 112
    
    //TODO: creare un unico metodo factory per le label
    lazy var typeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Account Type"
        return label
    }()
    
    lazy var underlineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = appColor
        view.widthAnchor.constraint(equalToConstant: 60).isActive = true
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        return view
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.text = "No-free All-In Chequing"
        return label
    }()
    
    lazy var balanceStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var balanceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Some Balance"
        return label
    }()
    
    lazy var balanceAmountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .body)
//        label.text = "$929,466.63"
        label.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")
        return label
    }()
    
    lazy var chevronImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        imageView.contentMode =  .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            underlineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            balanceStackView.topAnchor.constraint(equalTo: underlineView.bottomAnchor),
            balanceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            chevronImageView.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 8),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
}
//MARK: NSMutableAttributedString factory methods
extension AccountSummaryCell {
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension AccountSummaryCell {
    func configure(with viewModel: ViewModel){
        typeLabel.text = viewModel.accountType.rawValue
        nameLabel.text = viewModel.accountName
        balanceAmountLabel.attributedText = viewModel.balanceAsAttributedString
        
        switch viewModel.accountType {
            
        case .Banking:
            underlineView.backgroundColor = appColor
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
        case .Investment:
            underlineView.backgroundColor = .systemPurple
        }
    }
}
