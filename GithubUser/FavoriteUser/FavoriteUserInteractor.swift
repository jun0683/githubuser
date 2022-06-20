//
//  FavoriteUserInteractor.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserBusinessLogic {
    func loadFavoriteUser(request: FavoriteUser.LoadFavoriteUser.Request)
    func unFavoriteUser(request: FavoriteUser.UnfavoriteUser.Request)
    func searchUser(request: FavoriteUser.SearchUser.Request)
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
        
        presenter?.presentUnfavoriteUser(response: .init(user: request.user))
    }
    
    func searchUser(request: FavoriteUser.SearchUser.Request) {
        guard let userList = worker?.loadUserList() else { return }
        
        let searcedUser = userList.filter({ $0.name.lowercased().contains(request.name.lowercased()) })
        
        presenter?.presentUserList(response: .init(userList: searcedUser))
    }
}
