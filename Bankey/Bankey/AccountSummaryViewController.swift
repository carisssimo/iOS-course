//
//  AccountSummuryViewController.swift
//  Bankey
//
//  Created by simonecaria on 05/02/25.

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //Data
    var profile : Profile?
    var accounts : [Account] = []
//    |
//    V
    //View models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels : [AccountSummaryCell.ViewModel] = []
    
    var tableView = UITableView()
    var accountSummaryHeaderView = AccountSummaryHeaderView(frame: .zero)
    
    lazy var logoutBarButtonItem : UIBarButtonItem = {
        let barbutton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barbutton.tintColor = .label
        return barbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        fetchAccounts
        fetchDataAndLoadViews()
    }
}

extension AccountSummaryViewController {
    private func setupViews() {
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
    }
    
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView(){
        accountSummaryHeaderView = AccountSummaryHeaderView(frame: .zero)
        var size = accountSummaryHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        accountSummaryHeaderView.frame.size = size
        
        tableView.tableHeaderView = accountSummaryHeaderView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: actions
extension  AccountSummaryViewController {
    @objc func logoutTapped(){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

//MARK: fake call
extension AccountSummaryViewController {
    private func fetchAccounts(){
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                   accountName: "Basic Savings",
                                                   balance: 929466.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                accountName: "Visa Avion Card",
                                                balance: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                      accountName: "Student Mastercard",
                                                      balance: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)
        
        accountCellViewModels.append(savings)
        accountCellViewModels.append(chequing)
        accountCellViewModels.append(visa)
        accountCellViewModels.append(masterCard)
        accountCellViewModels.append(investment1)
        accountCellViewModels.append(investment2)
    }
}

//MARK: Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        fetchProfile(forUserId: "1", completion: { result in
            switch result {
            case .success(let profile) :
                self.profile = profile
                self.configureTableViewHeader(with: profile)
                self.tableView.reloadData()
            case .failure(let error) :
                print(error.localizedDescription)
            }
            
        })
        
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableViewHeader(with profile : Profile){
        let viewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: profile.firstName, date: Date())
        accountSummaryHeaderView.configure(viewModel: viewModel)
    }
    
    private func configureTableCells(with accounts : [Account]){
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
}
