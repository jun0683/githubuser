//
//  UserCell.swift
//  GithubUser
//
//  Created by hongjunkim on 2022/06/18.
//

import UIKit
import Kingfisher

final class UserCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
    
    func config(_ user: GitHubUserSearch.User) {
        if let url = try? user.profileUrl.asURL() {
            profileImageView.kf.setImage(with: url)
        }
        nickNameLabel.text = user.name
        favoriteButton.isSelected = user.favorite
    }
}

