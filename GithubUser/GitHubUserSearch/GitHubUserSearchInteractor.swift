//
//  GitHubUserSearchInteractor.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchBusinessLogic {
    func searchUser(request: GitHubUserSearch.SearchUser.Request)
    func favoriteUser(request: GitHubUserSearch.FavoriteUser.Request)
    func updateUnFavoriteUser(id: Int)
}

protocol GitHubUserSearchDataStore {
    //var name: String { get set }
}

final class GitHubUserSearchInteractor: GitHubUserSearchBusinessLogic, GitHubUserSearchDataStore {
    var presenter: GitHubUserSearchPresentationLogic?
    var worker: GitHubUserSearchWorkerProtocol?
    
    init(worker: GitHubUserSearchWorkerProtocol?) {
        self.worker = worker
    }
    
    func searchUser(request: GitHubUserSearch.SearchUser.Request) {
        let savedFatoriteUserList = worker?.getFavoriteUserList() ?? []
        
        worker?.searchUser(name: request.name, completion: { [weak self] result in
            if case let .success(test) = result {
                if test.totalCount == 0 {
                    self?.presenter?.presentSearchUser(response: .init(searchResultModel: .failure(NSError.emptyUser),
                                                                       savedFatoriteUserList: []))
                    return
                }
            }
            self?.presenter?.presentSearchUser(response: .init(searchResultModel: result, savedFatoriteUserList: savedFatoriteUserList))
        })
    }
    
    func favoriteUser(request: GitHubUserSearch.FavoriteUser.Request) {
        worker?.setFavoriteID(user: request.user)
        
        if let favorite = worker?.getFavoriteID(user: request.user) {
            presenter?.presentFavoriteUser(response: .init(id: request.user.id, favorite: favorite))
        }
    }
    
    func updateUnFavoriteUser(id: Int) {
        presenter?.presentFavoriteUserNotification(response: .init(id: id, favorite: false))
    }
}

extension NSError {
    static let emptyUser = NSError(domain: "",
                                   code: -1,
                                   userInfo:  [NSLocalizedDescriptionKey: "Empty user"])
}
