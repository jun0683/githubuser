//
//  FavoriteUserModels.swift
//  GithubUser
//

import UIKit

enum FavoriteUser {
    // MARK: Use cases
    
    enum LoadFavoriteUser {
        struct Request {
        }
        
        struct Response {
            let userList: [User]
        }
        
        struct ViewModel {
            var userList: [User]
        }
    }
    
    enum UnfavoriteUser {
        struct Request {
            let user: User
        }
        
        struct Response {
            let id: Int
        }
        
        struct ViewModel {
            let id: Int
        }
    }
}
