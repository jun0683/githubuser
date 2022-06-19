//
//  FavoriteUserViewController.swift
//  GithubUser
//

import UIKit

protocol FavoriteUserDisplayLogic: AnyObject {
    func displaySomething(viewModel: FavoriteUser.LoadFavoriteUser.ViewModel)
}


final class FavoriteUserViewController: UIViewController, FavoriteUserDisplayLogic {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: FavoriteUserBusinessLogic?
    var router: (NSObjectProtocol & FavoriteUserRoutingLogic & FavoriteUserDataPassing)?
    
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
        
        doSomething()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething() {
        let request = FavoriteUser.LoadFavoriteUser.Request()
        interactor?.loadFavoriteUser(request: request)
    }
    
    func displaySomething(viewModel: FavoriteUser.LoadFavoriteUser.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

extension FavoriteUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        guard name.isEmpty == false else { return }
        
        searchBar.resignFirstResponder()
    }
}
extension FavoriteUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteUserCell", for: indexPath) as UITableViewCell
        
        return cell
    }
}
