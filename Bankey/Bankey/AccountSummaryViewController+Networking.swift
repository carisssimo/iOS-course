//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by simonecaria on 12/02/25.
//

import Foundation
import UIKit


struct Account: Codable {
    let id: String
    let type: AccountType
    let name : String
    let amount : Decimal
    let createdDateTime : Date
    
    static func makeSkeleton() -> Account {
        return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }
}

extension AccountSummaryViewController {
    func fetchAccounts(forUserId userId: String) async throws -> [Account] {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts")!

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let accounts = try decoder.decode([Account].self, from: data)
            return accounts
        } catch {
            throw NetworkError.decodingError
        }
    }
}
