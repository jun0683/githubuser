//
//  GitHubUserSearchViewController.swift
//  GithubUser
//

import UIKit

protocol GitHubUserSearchDisplayLogic: AnyObject {
    func displaySearchUser(viewModel: GitHubUserSearch.SearchUser.ViewModel)
    func displayUpdateFavoriteUser()
    func displayError(error: Error)
}

final class GitHubUserSearchViewController: UIViewController, GitHubUserSearchDisplayLogic {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: GitHubUserSearchBusinessLogic?
    var dataSource: GitHubUserSearchDataSource?
    var router: (NSObjectProtocol & GitHubUserSearchRoutingLogic & GitHubUserSearchDataPassing)?
    weak var delegate: UpdateFavoriteUserDelegate?
    
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
        let interactor = GitHubUserSearchInteractor(worker: GitHubUserSearchWorker(db: GitHubUserGRDB.shared))
        let presenter = GitHubUserSearchPresenter()
        let router = GitHubUserSearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.dataSource = presenter
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
        tableView.reloadData()
    }
    
    func displayUpdateFavoriteUser() {
        delegate?.updateUser()
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
        searchBar.resignFirstResponder()
    }
}
extension GitHubUserSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.viewModel?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as UITableViewCell
        if let cell = cell as? UserCell,
           dataSource?.viewModel?.userList.count ?? 0 > indexPath.row,
           let user = dataSource?.viewModel?.userList[indexPath.row] {
            cell.config(user)
            cell.selectFavorite = { [weak self] in
                self?.interactor?.favoriteUser(request: .init(user: user))
            }
        }
        
        return cell
    }
}

extension GitHubUserSearchViewController: UITableViewDelegate {
    
}
