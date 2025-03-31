//
//  ProfileManager.swift
//  Bankey
//
//  Created by simonecaria on 18/02/25.
//

import Foundation

protocol ProfileManageable: AnyObject {
    func fetchProfile(forUserId userId: String) async throws -> Profile
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

class ProfileManager: ProfileManageable {
    func fetchProfile(forUserId userId: String) async throws -> Profile {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let profile = try JSONDecoder().decode(Profile.self, from: data)
            return profile
        } catch {
            throw NetworkError.decodingError
        }
        
        
    }
}
