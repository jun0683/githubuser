//
//  FavoriteUserPresenter.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserPresentationLogic {
    func presentUserList(response: FavoriteUser.LoadFavoriteUser.Response)
}

protocol FavoriteUserDataSource {
    var viewModel: FavoriteUser.LoadFavoriteUser.ViewModel? { get set }
}

final class FavoriteUserPresenter: FavoriteUserPresentationLogic, FavoriteUserDataSource {
    var viewModel: FavoriteUser.LoadFavoriteUser.ViewModel?
    weak var viewController: FavoriteUserDisplayLogic?
    
    // MARK: Do something
    
    func presentUserList(response: FavoriteUser.LoadFavoriteUser.Response) {
        let viewModel = FavoriteUser.LoadFavoriteUser.ViewModel(userList: response.userList)
        
        self.viewModel = viewModel
        
        viewController?.displayUserList(viewModel: viewModel)
    }
}
