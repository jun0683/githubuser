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
            self?.presenter?.presentSearchUser(response: .init(searchResultModel: result))
        })
    }
}
