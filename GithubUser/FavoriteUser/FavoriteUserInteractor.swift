//
//  FavoriteUserInteractor.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserBusinessLogic {
    func loadFavoriteUser(request: FavoriteUser.LoadFavoriteUser.Request)
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
}
