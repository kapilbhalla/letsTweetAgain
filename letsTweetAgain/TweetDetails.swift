//
//  TweetDetails.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class TweetDetails: UIViewController {

    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindView ()
        // Do any additional setup after loading the view.
    }
    
    func bindView () {
        if (tweet != nil){
            profileImage.setImageWith(URL(string: (tweet?.profileImageURL)!)!)
            name.text = tweet?.userName
            tweetText.text = tweet?.text
            favouritesCount.text = "\(tweet?.likesCount ?? 0)"
            retweetCount.text = "\(tweet?.retweetCount ?? 0)"
            
            //handle.text = tweet?.use
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTapFavourites(_ sender: Any) {
    }

    @IBAction func onTapReply(_ sender: Any) {
    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
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
