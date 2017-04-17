//
//  TweetsViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTableView.dataSource = self
        //adjust row height
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 100

        
        loadTweets()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tweetTableView: UITableView!
    
    var myTweets: [Tweet] = []
    
    func loadTweets () {
        TwitterClient.sharedInstance?.homeTimeLine(successCB: { (tweets: [Tweet]) in
            self.myTweets = tweets
            self.printTweets(tweets: tweets)
            
            // refresh the table view to load again
            self.tweetTableView.reloadData()
        }, failureCB: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    func printTweets (tweets: [Tweet]?){
        if let myTweets = tweets {
            for aTweet:Tweet in myTweets {
                print(aTweet.text)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Extract the cell displayed in the table view

        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        // Set the cell with appropriate data from the datastructure backing the table View
        cell.tweetText.text = myTweets[indexPath.row].text
        // myTweets[indexPath.row].
        cell.userName.text = myTweets[indexPath.row].userName
        let profileImageUrl = myTweets[indexPath.row].profileImageURL
        
        if let profileImageUrlUnwrapped = profileImageUrl {
            cell.profileImage.setImageWith(URL(string: profileImageUrlUnwrapped)!)
        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}