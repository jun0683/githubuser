//
//  GitHubUserSearchPresenter.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchPresentationLogic {
    func presentSearchUser(response: GitHubUserSearch.SearchUser.Response)
    func presentFavoriteUser(response: GitHubUserSearch.FavoriteUser.Response)
}

protocol GitHubUserSearchDataSource {
    var viewModel: GitHubUserSearch.SearchUser.ViewModel? { get set }
}

class GitHubUserSearchPresenter: GitHubUserSearchPresentationLogic, GitHubUserSearchDataSource {
    var viewModel: GitHubUserSearch.SearchUser.ViewModel?
    weak var viewController: GitHubUserSearchDisplayLogic?
    
    func presentSearchUser(response: GitHubUserSearch.SearchUser.Response) {
        switch response.searchResultModel {
        case .success(let result):
            let userList: [GitHubUserSearch.User] = result.items.map {
                .init(name: $0.login, profileUrl: $0.avatarURL, favorite: $0.favorite, id: $0.id)
            }
            let viewModel = GitHubUserSearch.SearchUser.ViewModel.init(userList: userList)
            self.viewModel = viewModel
            viewController?.displaySearchUser(viewModel: viewModel)
        case .failure(let error):
            viewController?.displayError(error: error)
        }
    }
    
    func presentFavoriteUser(response: GitHubUserSearch.FavoriteUser.Response) {
        guard var viewModel = viewModel else { return }
        
        if let userIndex = viewModel.userList.firstIndex(where: { $0.id == response.id }) {
            viewModel.userList[userIndex].favorite = response.favorite
        }
        
        self.viewModel = viewModel
        
        viewController?.displaySearchUser(viewModel: viewModel)
    }
}
