//
//  GitHubUserSearchPresenter.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchPresentationLogic {
    func presentSearchUser(response: GitHubUserSearch.SearchUser.Response)
}

class GitHubUserSearchPresenter: GitHubUserSearchPresentationLogic {
    weak var viewController: GitHubUserSearchDisplayLogic?
    
    // MARK: Do something
    
    func presentSearchUser(response: GitHubUserSearch.SearchUser.Response) {
        let viewModel = GitHubUserSearch.SearchUser.ViewModel()
        viewController?.displaySearchUser(viewModel: viewModel)
    }
}
