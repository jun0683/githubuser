//
//  GitHubUserDB.swift
//  GithubUser
//
//  Created by hongjunkim on 2022/06/19.
//

import Foundation

final class GitHubUserDB {
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
}
