//
//  ProfileViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/24/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var tweets: [Tweet] = []
    var user: User!
    var headerView: ProfileCell!
    
    var context = CIContext(options: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight = 300
        tableView.estimatedRowHeight = 200

    }
    
    @IBAction func onTapBack(_ sender: Any) {
        dismiss(animated: true) {
            print("heading back from user profile view")
            self.user = User.currentUser!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if user == nil {
            user = User.currentUser
        }
        getTweetsForUser(user: user)
        
        //headerView = Bundle.main.loadNibNamed("ProfileCell", owner: self, options: nil)?.first as! ProfileCell
        
       
    }
    
    func getTweetsForUser(user: User) {
        var parameters = [String: AnyObject]()
        parameters["count"] = 20 as AnyObject
        parameters["user_id"] = user.id as AnyObject
        
        TwitterClient.sharedInstance?.userTimeline(parameters: parameters ,success: { (tweets: [Tweet]?) in
            print("--------- \(tweets?.count ?? 0) Number of tweets retrieved for user profile")
            
            self.tweets += tweets!
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = Bundle.main.loadNibNamed("tweetCell", owner: self, options: nil)?.first as! TweetCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        switch indexPath.section {
        case 0:
            cell.tweet = tweets[indexPath.row]
        default:
            cell.tweet = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        headerView.user = user
//        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
//        headerView.setNeedsLayout()
//        headerView.layoutIfNeeded()
        //tableView.tableHeaderView = headerView
        
        return headerView
    }
    
}
