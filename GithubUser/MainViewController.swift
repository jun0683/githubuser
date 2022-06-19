//
//  MainViewController.swift
//  GithubUser
//

import UIKit

protocol UpdateFavoriteUserDelegate: AnyObject {
    func updateUser()
}

final class MainViewController: UIViewController, UpdateFavoriteUserDelegate {
    
    @IBOutlet weak var tabControl: UISegmentedControl!
    @IBOutlet weak var githubSearchView: UIView!
    @IBOutlet weak var favoriteUserView: UIView!
    
    var gitHubUserSearchViewController: GitHubUserSearchViewController?
    var favoriteUserViewController: FavoriteUserViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTab(tabControl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GitHubUserSearch",
           let gitHubUserSearchViewController = segue.destination as? GitHubUserSearchViewController {
            gitHubUserSearchViewController.delegate = self
        }
        if segue.identifier == "FavoriteUser",
           let favoriteUserViewController = segue.destination as? FavoriteUserViewController {
            self.favoriteUserViewController = favoriteUserViewController
        }
    }
    
    func updateUser() {
        favoriteUserViewController?.interactor?.loadFavoriteUser(request: .init())
    }
    
    @IBAction func onSelectTab(_ sender: UISegmentedControl) {
        updateTab(sender)
    }
    
    private func updateTab(_ sender: UISegmentedControl) {
        githubSearchView.isHidden = sender.selectedSegmentIndex != 0
        favoriteUserView.isHidden = sender.selectedSegmentIndex == 0
    }
}
