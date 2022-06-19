//
//  FavoriteUserPresenter.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserPresentationLogic {
    func presentSomething(response: FavoriteUser.LoadFavoriteUser.Response)
}

class FavoriteUserPresenter: FavoriteUserPresentationLogic {
    weak var viewController: FavoriteUserDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: FavoriteUser.LoadFavoriteUser.Response) {
        let viewModel = FavoriteUser.LoadFavoriteUser.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
