//
//  GitHubUserSearchWorker.swift
//  GithubUser
//

import UIKit
import Alamofire

final class GitHubUserSearchWorker {
    func searchUser(name: String, completion: @escaping (Result<SearchResultModel, Error>) -> Void) {
        let url = "https://api.github.com/search/users?q=\(name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        let headers = HTTPHeaders(["Accept": "application/vnd.github.v3+json"])

        AF.request(url, headers: headers)
            .responseDecodable { (response) in
                completion(self.trasform(response: response))
            }
    }
    
    func setFavoriteID(user: User) {
        GitHubUserGRDB.shared.setFavoriteID(user: user)
    }
    
    func getFavoriteID(user: User) -> Bool {
        GitHubUserGRDB.shared.getFavoriteID(user: user)
    }
    
    func getFavoriteUserList() -> [User] {
        GitHubUserGRDB.shared.getFavoriteUserList()
    }
    
    private func trasform<T: Decodable>(response: AFDataResponse<T>) -> Result<T, Error> {
        switch response.result {
            case .success(let model):
                return .success(model)
            case .failure(let error):
                if let underlyingError = error.underlyingError {
                    return  .failure(underlyingError)
                }
                
                return  .failure(error)
        }
    }
}
