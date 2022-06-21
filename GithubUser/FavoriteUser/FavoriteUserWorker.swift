//
//  FavoriteUserWorker.swift
//  GithubUser
//

import UIKit

class FavoriteUserWorker {
    func loadUserList() -> [User] {
        GitHubUserGRDB.shared.getFavoriteUserList()
    }
    
    func unfavoriteUser(user: User) {
        GitHubUserGRDB.shared.unfavoriteUser(user: user)
    }
}
