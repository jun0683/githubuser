//
//  FavoriteUserRouter.swift
//  GithubUser
//


import UIKit

protocol FavoriteUserRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FavoriteUserDataPassing {
    var dataStore: FavoriteUserDataStore? { get }
}

class FavoriteUserRouter: NSObject, FavoriteUserRoutingLogic, FavoriteUserDataPassing {
    weak var viewController: FavoriteUserViewController?
    var dataStore: FavoriteUserDataStore?
    
    // MARK: Routing
}
