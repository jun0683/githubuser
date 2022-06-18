//
//  Model.swift
//  GithubUser
//
//  Created by hongjunkim on 2022/06/18.
//

import Foundation

// MARK: - User
struct SearchResultModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    // MARK: - Item
    struct User: Codable {
        let login: String
        let id: Int
        let avatarURL: String
        var favorite: Bool = false
        
        enum CodingKeys: String, CodingKey {
            case login, id
            case avatarURL = "avatar_url"
        }
    }
}
