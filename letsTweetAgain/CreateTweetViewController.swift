//
//  CreateTweetViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit


protocol CreateTweetViewControllerDelegate {
    func createTweetViewController(createTweetViewController: CreateTweetViewController, didCreateTweet tweet: Tweet)
}

class CreateTweetViewController: UIViewController {

    var userDetails: User?
    var delegate: CreateTweetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUser()
        // Do any additional setup after loading the view.
    }
    
    func bindUser () {
        if (userDetails != nil){
            displayName.text = userDetails?.screenName
            name.text = userDetails?.name
            profileImage.setImageWith((userDetails?.profileURL)!)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onTapTweet(_ sender: Any) {
        if let newTweetMessage = tweetText.text {
            
            // Post the new tweet om Twitter
            TwitterClient.sharedInstance?.createNewTweet(withMessage: newTweetMessage, success: { (tweet: Tweet) in
                self.delegate?.createTweetViewController(createTweetViewController: self, didCreateTweet: tweet)
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tweetText: UITextField!
    @IBOutlet weak var displayName: UILabel!
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
