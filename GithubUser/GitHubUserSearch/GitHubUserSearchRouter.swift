//
//  GitHubUserSearchRouter.swift
//  GithubUser
//


import UIKit

protocol GitHubUserSearchRoutingLogic {
    func routeToSomewhere()
}

protocol GitHubUserSearchDataPassing {
    var dataStore: GitHubUserSearchDataStore? { get }
}

class GitHubUserSearchRouter: NSObject, GitHubUserSearchRoutingLogic, GitHubUserSearchDataPassing {
    weak var viewController: GitHubUserSearchViewController?
    var dataStore: GitHubUserSearchDataStore?
    
    // MARK: Routing
    
    func routeToSomewhere() {
    }
}
