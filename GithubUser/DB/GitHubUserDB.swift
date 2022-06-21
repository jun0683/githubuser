//
//  GitHubUserDB.swift
//  GithubUser
//
//  Created by hongjunkim on 2022/06/19.
//

import Foundation

protocol DBProtocol {
    func setFavoriteID(user: User)
    func getFavoriteID(user: User) -> Bool
    func unfavoriteUser(user: User)
    func getFavoriteUserList() -> [User]
}

final class GitHubUserDB: DBProtocol {
    static let shared = GitHubUserDB()
    
    private init() {}
    
    private var favoriteIDList: [Int: User] = [:]
    
    func setFavoriteID(user: User) {
        if let setedUser = favoriteIDList[user.id]?.favorite {
            favoriteIDList[user.id]?.favorite = !setedUser
        } else {
            var user = user
            user.favorite = true
            favoriteIDList[user.id] = user
        }
    }
    
    func getFavoriteID(user: User) -> Bool {
        if let getID = favoriteIDList[user.id] {
            return getID.favorite
        } else {
            favoriteIDList[user.id] = user
            
            return false
        }
    }
    
    func unfavoriteUser(user: User) {
        favoriteIDList[user.id] = nil
    }
    
    func getFavoriteUserList() -> [User] {
        favoriteIDList.values.filter({
            $0.favorite
        })
    }
}
