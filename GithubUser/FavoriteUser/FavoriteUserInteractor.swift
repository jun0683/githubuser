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
        worker?.doSomeWork()
        
        let response = FavoriteUser.LoadFavoriteUser.Response()
        presenter?.presentSomething(response: response)
    }
}
