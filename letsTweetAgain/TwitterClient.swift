//
//  TwitterClient.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    // Single client that can be used throughout the application
    
    static let sharedInstance = TwitterClient (baseURL: NSURL(string: "https://api.twitter.com") as! URL, consumerKey: "ZAGlDoZ4vkMoi7VtNRnogjJEE", consumerSecret: "l48UW8Ze1ciCg7sHpPwhVGhzCzyNJEPGen5LYevfEBPimjsIoG")
    

    // the hometime line api interacts to the server to fetch the tweets.
    // in case of success the function will call a callback and return an array of tweets
    // in case of failure we would call the error callback
    func homeTimeLine (successCB: @escaping ([Tweet]) -> (),
                       failureCB: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
                           success: { (task: URLSessionDataTask, response:Any?) in
//                            print ("tweets")
                            let tweetDictionaries = response as! [NSDictionary]
                            
                            let tweets = Tweet.tweetsWithArray(tweetDictionaries: tweetDictionaries)
                            
                            successCB(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failureCB(error)
        })
    }
    
    let twitterMentionsPath = "1.1/statuses/mentions_timeline.json"
    func mentions(parameters: [String: AnyObject]? ,success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get(twitterMentionsPath, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionariesArray = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(tweetDictionaries: dictionariesArray)
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error?) in
            
            failure(error!)
            
        })
    }

    
    let twitterUserTimeLinePath = "1.1/statuses/user_timeline.json"
    func userTimeline(parameters: [String: AnyObject]? ,success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get(twitterUserTimeLinePath, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(tweetDictionaries: tweetDictionaries)
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error?) in
            
            failure(error!)
            
        })
    }

    
    func validateUser(successCB: @escaping (User) -> (),
                      failuerCB: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
                           success: { (task: URLSessionDataTask, response: Any?) -> Void in
                            print("account: \(response)")
                            
                            
                            let responseDictionary = response as! NSDictionary
                            let user = User(userDictionary: responseDictionary)
        
                            successCB(user)
                            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failuerCB(error)
        })
    }
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error)->())?
    
    /*
     The login function is responsible to execute the Oauth1.0a protocol and call the completion handler as required
     */
    func login (success: @escaping ()->(), failure: @escaping (Error)->()){
        
        loginSuccess = success
        loginFailure = failure
        
        // There is a bug in BDBOAuth1Manager that needs the session to be cleaned before the login.
        deauthorize()
        
        // 2. prove to twitter that we are the letsTweetAgain app.
        // https://api.twitter.com/oauth/request_token
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"letstweetagain://oauth") as! URL, scope: nil, success: { (oauthToken: BDBOAuth1Credential?) -> Void in
            
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
            if let errorUnwrapped = error {
                self.loginFailure?(errorUnwrapped)
            }
        })
    }
    
    private let createNewTweetEndpoint = "1.1/statuses/update.json"
    func createNewTweet(withMessage text: String, success: @escaping (Tweet) -> () , failure: @escaping (Error) -> ()) {
        let param: [String: Any] = ["status": text]
        post(createNewTweetEndpoint, parameters: param, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let tweet = Tweet(tweetDictionary: response as! NSDictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        }
    }
    
    
    private let retweetEndpoint = "1.1/statuses/retweet/:id.json"
    func retweeting(withID id: NSNumber, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let retweetingEndpoint = retweetEndpoint.replacingOccurrences(of: ":id", with: "\(id)")
        let param: [String: Any] = ["id": id]
        post(retweetingEndpoint, parameters: param, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let tweet = Tweet(tweetDictionary: response as! NSDictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    private let markAsFavoriteEndpoint = "1.1/favorites/create.json"
    func markAsFavorite(withID id: NSNumber, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let param: [String: Any] = ["id": id]
        post(markAsFavoriteEndpoint, parameters: param, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let tweet = Tweet(tweetDictionary: response as! NSDictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        // Go back to the Login window
        NotificationCenter.default.post(name: NSNotification.Name(User.didLogOutNotification), object: nil)
    }
    
    /*
        Handle open url function is called from the appDelegate when the system notifies that a command handling request is
        being posted. On this we have already saved callback handlers when the original login was requested.
        we will use the preseaved call back handlers to complete this functionality.
     */
    func handleOpenURL (open url: URL) {
        let requestToken = BDBOAuth1Credential (queryString: url.query)
        
        fetchAccessToken(withPath: "/oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
           // print ("I got the access token")

            self.loginSuccess?()
        }, failure: { (error: Error?) in
            print (error?.localizedDescription)
            if let errorUnwrapped = error {
                self.loginFailure?(errorUnwrapped)
            }
        })

    }
}
