//
//  GitHubUserSearchWorkerProtocol.swift
//  GithubUser
//
//  Created by hongjunkim on 2022/06/22.
//

import Foundation

protocol GitHubUserSearchWorkerProtocol {
    var db: DBProtocol { get }
    func searchUser(name: String, completion: @escaping (Result<SearchResultModel, Error>) -> Void)
    func setFavoriteID(user: User)
    func getFavoriteID(user: User) -> Bool
    func getFavoriteUserList() -> [User]
}
