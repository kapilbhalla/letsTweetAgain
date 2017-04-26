//
//  MenuViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/24/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamMenuViewController!
    
    private var profileViewController: ProfileViewController!
    private var homeTimeLineViewController: UINavigationController!
    private var mentionsViewController: MentionsViewController!
    private var accountsViewController: AccountViewController!
    let menuLabels = ["Profile", "TimeLine", "Mentions", "Accounts"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self as! UITableViewDelegate
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        print("Hello from Menu view c")
        instantiateViewControllers()
        hamburgerViewController.contentViewController = viewControllers[1]
    }

    private func instantiateViewControllers() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyBoard.instantiateViewController(withIdentifier: "UserProfileView") as! ProfileViewController
        homeTimeLineViewController = storyBoard.instantiateViewController(withIdentifier:
            "TweetsNavigationController") as! UINavigationController
        mentionsViewController = storyBoard.instantiateViewController(withIdentifier: "MentionsView") as! MentionsViewController
        accountsViewController = storyBoard.instantiateViewController(withIdentifier: "AccountView") as! AccountViewController
//        accountsViewController.hamburgerViewController = hamburgerViewController
//        accountsViewController.homeTimeLineViewController = homeTimeLineViewController
        //accountsViewController.didLoadFromSegue = false
        
        viewControllers.append(profileViewController)
        viewControllers.append(homeTimeLineViewController)
        viewControllers.append(mentionsViewController)
        //viewControllers.append(accountsViewController)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCellTableViewCell
        cell.menuLabel.text = menuLabels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
}

