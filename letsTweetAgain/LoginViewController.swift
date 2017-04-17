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
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.login(success: { () -> () in
            print("Iam logged in")
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
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
