//
//  MentionsViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/26/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource {

    var myTweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        //adjust row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        loadMentionsTweets()
        // Do any additional setup after loading the view.
    }
    
    func loadTweets () {
        TwitterClient.sharedInstance?.homeTimeLine(successCB: { (tweets: [Tweet]) in
            self.myTweets = tweets
            
            // refresh the table view to load again
            self.tableView.reloadData()
        }, failureCB: { (error: Error) in
            print(error.localizedDescription)
        })
    }

    func loadMentionsTweets () {
        
        var parameters = [String: AnyObject]()
        parameters["count"] = 20 as AnyObject
        
        
        TwitterClient.sharedInstance?.mentions(parameters: parameters, success: { (tweets: [Tweet]) in
            self.myTweets = tweets
            
            // refresh the table view to load again
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        if (myTweets.count == 0){
            loadTweets()
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
        // set the tweet in the tweet cell.
        cell.tweet = myTweets[indexPath.row]
        //cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}
