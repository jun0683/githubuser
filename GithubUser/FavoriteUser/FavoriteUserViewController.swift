//
//  FavoriteUserViewController.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserDisplayLogic: AnyObject {
    func displayUserList(viewModel: FavoriteUser.LoadFavoriteUser.ViewModel)
    func displayUpdateUnfavoriteUser(viewModel: FavoriteUser.UnfavoriteUser.ViewModel)
}


final class FavoriteUserViewController: UIViewController, FavoriteUserDisplayLogic {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: FavoriteUserBusinessLogic?
    var dataSource: FavoriteUserDataSource?
    var router: (NSObjectProtocol & FavoriteUserRoutingLogic & FavoriteUserDataPassing)?
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
        let interactor = FavoriteUserInteractor()
        let presenter = FavoriteUserPresenter()
        let router = FavoriteUserRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.dataSource = presenter
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.loadFavoriteUser(request: .init())
    }
    
    func displayUserList(viewModel: FavoriteUser.LoadFavoriteUser.ViewModel) {
        tableView.reloadData()
    }
    
    func displayUpdateUnfavoriteUser(viewModel: FavoriteUser.UnfavoriteUser.ViewModel) {
        delegate?.updateUnFavoriteUser(id: viewModel.id)
    }
}

extension FavoriteUserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            interactor?.loadFavoriteUser(request: .init())
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        guard name.isEmpty == false else { return }
        
        interactor?.searchUser(request: .init(name:  name))
        
        searchBar.resignFirstResponder()
    }
}
extension FavoriteUserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource?.viewModel?.sectionCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.viewModel?.sectionUserCount(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSource?.viewModel?.sectionName(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteUserCell", for: indexPath) as UITableViewCell
        
        if let cell = cell as? FavoriteUserCell,
           let user = dataSource?.viewModel?.user(indexPath: indexPath) {
            cell.config(user)
            cell.selectFavorite = { [weak self] in
                self?.interactor?.unFavoriteUser(request: .init(user: user))
            }
        }
        
        return cell
    }
}
