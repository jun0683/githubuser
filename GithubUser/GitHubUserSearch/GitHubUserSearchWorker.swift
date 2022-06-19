//
//  GitHubUserSearchWorker.swift
//  GithubUser
//

import UIKit
import Alamofire

final class GitHubUserSearchWorker {
    var favoriteIDList: [Int: Bool] = [:]
    
    func searchUser(name: String, completion: @escaping (Result<SearchResultModel, Error>) -> Void) {
        let url = "https://api.github.com/search/users?q=\(name)"
        let headers = HTTPHeaders(["Accept": "application/vnd.github.v3+json"])

        AF.request(url, headers: headers)
            .responseDecodable { (response) in
                completion(self.trasform(response: response))
            }
    }
    
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
