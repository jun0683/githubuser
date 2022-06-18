//
//  GitHubUserSearchViewController.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchDisplayLogic: AnyObject {
    func displaySearchUser(viewModel: GitHubUserSearch.SearchUser.ViewModel)
    func displayError(error: Error)
}

final class GitHubUserSearchViewController: UIViewController, GitHubUserSearchDisplayLogic {
    @IBOutlet weak var searchBar: UISearchBar!
    var interactor: GitHubUserSearchBusinessLogic?
    var router: (NSObjectProtocol & GitHubUserSearchRoutingLogic & GitHubUserSearchDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = GitHubUserSearchInteractor()
        let presenter = GitHubUserSearchPresenter()
        let router = GitHubUserSearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func displaySearchUser(viewModel: GitHubUserSearch.SearchUser.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    func displayError(error: Error) {
        let errorAlert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(ok)
        
        present(errorAlert, animated: true, completion: nil)
    }
}

extension GitHubUserSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        guard name.isEmpty == false else { return }
        
        interactor?.searchUser(request: .init(name:  name))
    }
}
