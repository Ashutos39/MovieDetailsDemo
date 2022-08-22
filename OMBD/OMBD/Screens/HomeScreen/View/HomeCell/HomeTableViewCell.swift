//
//  HomeTableViewCell.swift
//  GithubDemo
//
//  Created by Ashutos Sahoo on 03/08/22.
//

import UIKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var bgview: UIView!    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgview.addCornerRadius(withRadius: 10.0)
        profileImageView.addCornerRadius(withRadius: 10.0)
    }
    
    func setUpUI(userModel : Search?) {
        guard let movieData = userModel else { return }
        titleLabel.text = movieData.title ?? ""
        if let imageString = movieData.poster, let url = URL(string: imageString)  {
            profileImageView.kf.setImage(with: url)
        }
    }
}
