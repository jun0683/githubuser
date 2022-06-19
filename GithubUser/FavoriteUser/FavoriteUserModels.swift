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
            let userList: [User]
        }
    }
}
