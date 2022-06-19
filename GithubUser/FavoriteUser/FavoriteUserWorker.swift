//
//  FavoriteUserWorker.swift
//  GithubUser
//

import UIKit

class FavoriteUserWorker {
    func loadUserList() -> [User] {
        GitHubUserDB.shared.getFavoriteUserList()
    }
    
    func unfavoriteUser(user: User) {
        GitHubUserDB.shared.unfavoriteUser(user: user)
    }
}
