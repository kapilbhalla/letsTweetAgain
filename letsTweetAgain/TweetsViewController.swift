//
//  TweetsViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        // Tell the refreshControl to stop spinning
        if (refreshControl.isRefreshing){
            refreshControl.endRefreshing()
        } else {
            loadTweets()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTableView.dataSource = self
        //adjust row height
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 100

        // Initialize a UIRefreshControl
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        
        // add refresh control to table view
        tweetTableView.insertSubview(refreshControl, at: 0)
        loadUser()
        loadTweets()
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBOutlet weak var tweetTableView: UITableView!
    var myTweets: [Tweet] = []
    var currentUser: User?
    
    func loadUser () {
        TwitterClient.sharedInstance?.validateUser(successCB: { (returnedUser: User) in
           self.currentUser = returnedUser
        }, failuerCB: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
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
    
    private func customizeNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 64/255, green: 153/255, blue: 255/255, alpha: 1)
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = .white
            
            let attributeColor = UIColor.white
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: attributeColor]
        }
    }
    
    @IBAction func onTweet(_ sender: Any) {
//        if let targetVC = storyboard?.instantiateViewController(withIdentifier: "createTweet") as? CreateTweetViewController {
//            
//            targetVC.userDetails = currentUser
//            self.present(targetVC, animated: true, completion: nil)
//        }
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
        
        let screenName: String = myTweets[indexPath.row].screenName!
        cell.userHandle.text = screenName
        
        let profileImageUrl = myTweets[indexPath.row].profileImageURL
        
        if let profileImageUrlUnwrapped = profileImageUrl {
            cell.profileImage.setImageWith(URL(string: profileImageUrlUnwrapped)!)
        }
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as? UINavigationController
        if let destinationVC = navigationController?.topViewController as? CreateTweetViewController {
            destinationVC.userDetails = self.currentUser
            //destinationVC.delegate = self
        }
        if let destinationVC = navigationController?.topViewController as? TweetDetails {
            let index = tweetTableView.indexPath(for: sender as! TweetCell)
            destinationVC.tweet = myTweets[(index?.row)!]
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            let tweetViewController = segue.destination as! TweetDetails
//            let index = tweetTableView.indexPath(for: sender as! TweetCell)
//            tweetViewController.tweet = myTweets[(index?.row)!]
//        }
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
