//
//  FavoriteUserWorker.swift
//  GithubUser
//

import UIKit

class FavoriteUserWorker {
    let db: DBProtocol
    
    init(db: DBProtocol) {
        self.db = db
    }
    
    func loadUserList() -> [User] {
        db.getFavoriteUserList()
    }
    
    func unfavoriteUser(user: User) {
        db.unfavoriteUser(user: user)
    }
}
