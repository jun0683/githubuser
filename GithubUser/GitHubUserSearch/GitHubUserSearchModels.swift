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
        var favorite: Bool
        let id: Int
    }
    
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
            let id: Int
        }
        
        struct Response {
            let id: Int
            let favorite: Bool
        }
    }
}
