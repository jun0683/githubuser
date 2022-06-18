//
//  GitHubUserSearchModels.swift
//  GithubUser
//

import UIKit

enum GitHubUserSearch {
    // MARK: Use cases
    struct User {
        let name: String
        let profileUrl: String
        let favorite: Bool
    }
    
    enum SearchUser {
        struct Request {
            let name: String
        }
        
        struct Response {
            let searchResultModel: Result<SearchResultModel, Error>
        }
        
        struct ViewModel {
            let userList: [User]
        }
    }
}
