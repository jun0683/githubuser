//
//  FavoriteUserInteractor.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserBusinessLogic {
    func loadFavoriteUser(request: FavoriteUser.LoadFavoriteUser.Request)
    func unFavoriteUser(request: FavoriteUser.UnfavoriteUser.Request)
}

protocol FavoriteUserDataStore {
    
}

class FavoriteUserInteractor: FavoriteUserBusinessLogic, FavoriteUserDataStore {
    var presenter: FavoriteUserPresentationLogic?
    var worker: FavoriteUserWorker? = FavoriteUserWorker()
    
    func loadFavoriteUser(request: FavoriteUser.LoadFavoriteUser.Request) {
        guard let userList = worker?.loadUserList() else { return }
        
        presenter?.presentUserList(response: .init(userList: userList))
    }
    
    func unFavoriteUser(request: FavoriteUser.UnfavoriteUser.Request) {
        worker?.unfavoriteUser(user: request.user)
        
        presenter?.presentUnfavoriteUser(response: .init(id: request.user.id))
    }
}
