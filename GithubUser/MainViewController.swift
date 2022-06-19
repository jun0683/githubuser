//
//  MainViewController.swift
//  GithubUser
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak var tabControl: UISegmentedControl!
    @IBOutlet weak var githubSearchView: UIView!
    @IBOutlet weak var favoriteUserView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTab(tabControl)
    }
    
    @IBAction func onSelectTab(_ sender: UISegmentedControl) {
        updateTab(sender)
    }
    
    private func updateTab(_ sender: UISegmentedControl) {
        githubSearchView.isHidden = sender.selectedSegmentIndex != 0
        favoriteUserView.isHidden = sender.selectedSegmentIndex == 0
    }
}
