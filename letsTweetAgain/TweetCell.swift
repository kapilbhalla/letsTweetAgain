//
//  TweetCell.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit


protocol TweetCellDelegate: class {
    
    func replyButtonTapped(tweetCell: TweetCell)
    func retweetButtonTapped(tweetCell: TweetCell)
    func favouriteTapped(tweetCell: TweetCell)
    func profileImageTapped(tweetCell: TweetCell)
    
}

class TweetCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        addGesturesToImages()
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    weak var delegate: TweetCellDelegate!


    func addGesturesToImages() {
        //reply button
        var gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(replyTapped))
        self.replyImage.addGestureRecognizer(gesture)
        
        //re tweet button
        gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(retweetTapped))
        self.retweetImg.addGestureRecognizer(gesture)
        
        //like button
        gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(favouriteTapped))
        self.favouriteImage.addGestureRecognizer(gesture)
        
        //avatar button
        gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(profileImageTapped))
        self.profileImage.addGestureRecognizer(gesture)
    }

    func replyTapped() {
        delegate?.replyButtonTapped(tweetCell: self)
    }
    
    func retweetTapped() {
        delegate?.retweetButtonTapped(tweetCell: self)
    }
    
    func favouriteTapped() {
        delegate?.favouriteTapped(tweetCell: self)
    }
    
    func profileImageTapped() {
        delegate?.profileImageTapped(tweetCell: self)
    }
    

    
    //weak var delegate: TweetCellDelegate!
    var indexPath: IndexPath!
    
    var tweet: Tweet! {
        didSet {
            
            // Set the cell with appropriate data from the datastructure backing the table View
            tweetText.text = tweet.text
            // myTweets[indexPath.row].
            userName.text = tweet.userName
            
            let screenName: String = tweet.screenName!
            userHandle.text = screenName
            
            let profileImageUrl = tweet.profileImageURL
            
            if let profileImageUrlUnwrapped = profileImageUrl {
                profileImage.setImageWith(URL(string: profileImageUrlUnwrapped)!)
            }
            
            //timestamp.text = tweet.timeStamp.characters.contains("s") ? " · Just now" : " · \(tweet.timeStamp)"
            
            if tweet.isYourRetweet {
                retweetImg.image = #imageLiteral(resourceName: "Retweet-gree")
            }
            else {
                retweetImg.image = #imageLiteral(resourceName: "Retweet-64")
            }
            
            if tweet.isYourFavorited {
                favouriteImage.image = #imageLiteral(resourceName: "Like Filled-50")
            }
            else {
                favouriteImage.image = #imageLiteral(resourceName: "Like-50")
            }
            
            if !tweet.isTweet {
                //tweetTypeImg.image = #imageLiteral(resourceName: "Retweet-64")
                retweetDetails.text = (tweet.isYourRetweet ? "You" : tweet.retweetName!) + " Retweeted"
                //tweetByHeightCons.constant = 12
                //tweetTypeImgHeightCons.constant = 15
            }
            //else {
                //tweetByHeightCons.constant = 0
                //tweetTypeImgHeightCons.constant = 0
            //}
        }
    }
    
    @IBOutlet weak var favouriteImage: UIImageView!
    @IBOutlet weak var retweetImg: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetDetails: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
}
