//
//  GitHubUserSearchPresenter.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchPresentationLogic {
    func presentSearchUser(response: GitHubUserSearch.SearchUser.Response)
}

protocol GitHubUserSearchDataSource {
    var viewModel: GitHubUserSearch.SearchUser.ViewModel? { get set }
}

class GitHubUserSearchPresenter: GitHubUserSearchPresentationLogic, GitHubUserSearchDataSource {
    var viewModel: GitHubUserSearch.SearchUser.ViewModel?
    
    weak var viewController: GitHubUserSearchDisplayLogic?
    
    // MARK: Do something
    
    func presentSearchUser(response: GitHubUserSearch.SearchUser.Response) {
        switch response.searchResultModel {
        case .success(let result):
            let userList: [GitHubUserSearch.User] = result.items.map {
                .init(name: $0.login, profileUrl: $0.avatarURL, favorite: $0.favorite)
            }
            let viewModel = GitHubUserSearch.SearchUser.ViewModel.init(userList: userList)
            self.viewModel = viewModel
            viewController?.displaySearchUser(viewModel: viewModel)
        case .failure(let error):
            viewController?.displayError(error: error)
        }
    }
}
