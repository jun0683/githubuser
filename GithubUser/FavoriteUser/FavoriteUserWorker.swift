//
//  FavoriteUserWorker.swift
//  GithubUser
//

import UIKit

class FavoriteUserWorker {
    func loadUserList() -> [User] {
        GitHubUserDB.shared.getFavoriteUserList()
    }
}
