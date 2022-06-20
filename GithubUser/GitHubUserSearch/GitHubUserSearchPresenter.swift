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
            let userList: [User] = searchUserListFavoriteStateUpdate(result, response)
            
            let viewModel = GitHubUserSearch.SearchUser.ViewModel.init(userList: userList)
            
            self.viewModel = viewModel
            
            viewController?.displaySearchUser(viewModel: viewModel)
        case .failure(let error):
            viewController?.displayError(error: error)
        }
    }
    
    private func searchUserListFavoriteStateUpdate(_ result: (SearchResultModel), _ response: GitHubUserSearch.SearchUser.Response) -> [User] {
        return result.items.map {
            .init(name: $0.login, profileUrl: $0.avatarURL, favorite: $0.favorite, id: $0.id)
        }.map({ (user: User) -> User in
            if response.savedFatoriteUserList.contains(where: { $0.id == user.id }) {
                var user = user
                user.favorite = true
                return user
            } else {
                return user
            }
        })
    }
    
    func presentFavoriteUser(response: GitHubUserSearch.FavoriteUser.Response) {
        guard var viewModel = viewModel else { return }
        
        if let userIndex = viewModel.userList.firstIndex(where: { $0.id == response.id }) {
            viewModel.userList[userIndex].favorite = response.favorite
        }
        
        self.viewModel = viewModel
        
        viewController?.displaySearchUser(viewModel: viewModel)
        viewController?.displayUpdateFavoriteUser()
    }
}
