//
//  GitHubUserSearchModels.swift
//  GithubUser
//

import UIKit

enum GitHubUserSearch {
    // MARK: Use cases
    
    enum SearchUser {
        struct Request {
            let name: String
        }
        
        struct Response {
            let searchResultModel: Result<SearchResultModel, Error>
        }
        
        struct ViewModel {
            var userList: [User]
        }
    }
    
    enum FavoriteUser {
        struct Request {
            let user: User
        }
        
        struct Response {
            let id: Int
            let favorite: Bool
        }
    }
}
