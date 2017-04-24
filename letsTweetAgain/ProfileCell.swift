//
//  ProfileCell.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/24/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var userBackgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userScreeNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User! {
        didSet {
            userBackgroundImageView.setImageWith(user.profileBackgroundImageUrl!)
            userScreeNameLabel.text = user.screenName!
            userNameLabel.text = "@" + user.name!
            followersCountLabel.text = String(user.followerCount!)
            followingCountLabel.text = String(user.followingCount!)
            tweetCountLabel.text = String(user.tweetCount!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userImageView.layer.cornerRadius = 5
        self.userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
