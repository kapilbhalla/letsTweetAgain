//
//  LoginViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/15/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: Any) {
        
        // 1. create a client for twitter using the consumer key and consumer secret
        let twitterClient = BDBOAuth1SessionManager (baseURL: NSURL(string: "https://api.twitter.com") as! URL, consumerKey: "ZAGlDoZ4vkMoi7VtNRnogjJEE", consumerSecret: "l48UW8Ze1ciCg7sHpPwhVGhzCzyNJEPGen5LYevfEBPimjsIoG")
        
        // There is a bug in BDBOAuth1Manager that needs the session to be cleaned before the login.
        twitterClient?.deauthorize()
        
        // 2. prove to twitter that we are the letsTweetAgain app.
        // https://api.twitter.com/oauth/request_token
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"letstweetagain://oauth") as! URL, scope: nil, success: { (oauthToken: BDBOAuth1Credential?) -> Void in
            
            print ("i have got the token")
            // now we need to authorize the session with the token
            let oToken = oauthToken?.token
            let authorizeQueryParameter = ("https://api.twitter.com/oauth/authorize?oauth_token="+oToken!) as String
            
            //let url = NSURL(string: "https://api.twitter.com/oauth/authorize\(authorizeQueryParameter)")
            
            let authorizeUrl = NSURL(string: authorizeQueryParameter)
            
            // open the url in the url handling client in ios
            UIApplication.shared.openURL(authorizeUrl! as URL)
        }, failure: { (error: Error?) -> Void in
            print ("error: \(error?.localizedDescription)")
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
