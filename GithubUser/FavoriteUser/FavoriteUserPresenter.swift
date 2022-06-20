//
//  FavoriteUserPresenter.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserPresentationLogic {
    func presentUserList(response: FavoriteUser.LoadFavoriteUser.Response)
    func presentUnfavoriteUser(response: FavoriteUser.UnfavoriteUser.Response)
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
    
    func presentUnfavoriteUser(response: FavoriteUser.UnfavoriteUser.Response) {
        guard var viewModel = viewModel else { return }
        
        viewModel.userList = viewModel.userList.filter({ $0.id != response.id })
        
        self.viewModel = viewModel
        
        viewController?.displayUserList(viewModel: viewModel)
        viewController?.displayUpdateUnfavoriteUser(viewModel: .init(id: response.id))
    }
}
