//
//  GitHubUserSearchInteractor.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchBusinessLogic {
    func searchUser(request: GitHubUserSearch.SearchUser.Request)
}

protocol GitHubUserSearchDataStore {
    //var name: String { get set }
}

final class GitHubUserSearchInteractor: GitHubUserSearchBusinessLogic, GitHubUserSearchDataStore {
    var presenter: GitHubUserSearchPresentationLogic?
    var worker: GitHubUserSearchWorker? = GitHubUserSearchWorker()
    
    // MARK: Do something
    
    func searchUser(request: GitHubUserSearch.SearchUser.Request) {
        worker?.searchUser(name: request.name, completion: { [weak self] result in
            if case let .success(test) = result {
                if test.totalCount == 0 {
                    self?.presenter?.presentSearchUser(response: .init(searchResultModel: .failure(NSError(domain: "", code: -1, userInfo:  [NSLocalizedDescriptionKey: "Empty user"]))))
                } else {
                    self?.presenter?.presentSearchUser(response: .init(searchResultModel: result))
                }
            } else {
                self?.presenter?.presentSearchUser(response: .init(searchResultModel: result))
            }
        })
    }
}
