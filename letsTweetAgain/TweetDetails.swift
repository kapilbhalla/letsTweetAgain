//
//  TweetDetails.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class TweetDetails: UIViewController {

    var tweet: Tweet?{
        didSet {
            //bindView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindView ()
        customizeNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func bindView () {
        if (tweet != nil){
            profileImage.setImageWith(URL(string: (tweet?.profileImageURL)!)!)
            name.text = tweet?.userName
            tweetText.text = tweet?.text
            favouritesCount.text = "\(tweet?.likesCount ?? 0)"
            retweetCount.text = "\(tweet?.retweetCount ?? 0)"
            handle.text = tweet?.screenName
            if (tweet!.isTweet){
                retweetLabel.text = ""
            } else {
                retweetLabel.text = tweet?.retweetName
            }
            //handle.text = tweet?.use
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapFavourites(_ sender: Any) {
        if let id = tweet?.id {
            TwitterClient.sharedInstance?.markAsFavorite(withID: id, success: { (tweet: Tweet) in
                
                // Update tweet's data
                self.tweet = tweet
                self.bindView()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }

    private func customizeNavigationBar() {
//        navigationController?.navigationBar.barTintColor = UIColor(red: 64/255, green: 153/255, blue: 255/255, alpha: 1)
//        
//        if let navigationBar = navigationController?.navigationBar {
//            navigationBar.tintColor = .white
//            
//            let attributeColor = UIColor.white
//            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: attributeColor]
//        }
    }

    @IBAction func onTapReply(_ sender: Any) {
        print("Tap reply clicked")
    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
        if let id = tweet?.id {
            TwitterClient.sharedInstance?.retweeting(withID: id, success: { (tweet: Tweet) in
                
                // Update tweet's data
                self.tweet = tweet
                self.bindView()

            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true) { 
        }
    }
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favouritesCount: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
