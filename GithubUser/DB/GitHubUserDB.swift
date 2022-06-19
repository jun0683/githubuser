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
    
    private var favoriteIDList: [Int: Bool] = [:]
    
    func setFavoriteID(id: Int) {
        if let setedID = favoriteIDList[id] {
            favoriteIDList[id] = !setedID
        } else {
            favoriteIDList[id] = true
        }
    }
    
    func getFavoriteID(id: Int) -> Bool {
        if let getID = favoriteIDList[id] {
            return getID
        } else {
            favoriteIDList[id] = false
            
            return false
        }
    }
}
