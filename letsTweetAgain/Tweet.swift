//
//  Tweet.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var isTweet: Bool = true
    var tweetId: Int = 0
    var isYourFavorited: Bool = false
    var isYourRetweet: Bool = false
    
    var text: String?
    var retweetCount: Int = 0
    var likesCount: Int = 0
    var timeStamp: Date?
    var screenName: String?
    var retweetName: String?
    var user: NSDictionary?
    
    var profileImageURL: String?
    
    var userName: String?
    
    var id: NSNumber?
    
    
    
    init (tweetDictionary: NSDictionary){
        print (tweetDictionary)
        
        isYourRetweet = (tweetDictionary["retweeted"] as? Bool) ?? false
        isYourFavorited = (tweetDictionary["favorited"] as? Bool) ?? false
        
        id = tweetDictionary["id"] as? NSNumber
        
        user = tweetDictionary["user"] as? NSDictionary
        profileImageURL = user?["profile_image_url_https"] as? String
        
        let timeStampString = tweetDictionary["created_at"] as? String
        
        if let timeStampStringUnwrapped = timeStampString {
            let timeStampFormatter = DateFormatter()
            timeStampFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = timeStampFormatter.date(from: timeStampStringUnwrapped)
        }
        
        
        let retweetedStatus = tweetDictionary.value(forKeyPath: "retweeted_status") as? NSDictionary
        if retweetedStatus != nil {
            //this is retweet
            isTweet = false
            
            //text
            text = tweetDictionary.value(forKeyPath: "retweeted_status.text") as? String
            //retweetCount
            retweetCount = (tweetDictionary.value(forKeyPath: "retweeted_status.retweet_count") as? Int) ?? 0
            //favoriteCount
            likesCount = (tweetDictionary.value(forKeyPath: "retweeted_status.favorite_count") as? Int) ?? 0
            //name
            userName = (tweetDictionary.value(forKeyPath: "retweeted_status.user.name") as? String)!
            //screen name
            screenName = "@" + (tweetDictionary.value(forKeyPath: "retweeted_status.user.screen_name") as? String)!
            //profile url
            profileImageURL = tweetDictionary.value(forKeyPath: "retweeted_status.user.profile_image_url_https") as? String
            
            //retweet name
            retweetName = tweetDictionary.value(forKeyPath: "user.name") as? String
            
        } else {
            //this is tweet
            //text
            text = tweetDictionary["text"] as? String
            //retweetCount
            retweetCount = (tweetDictionary["retweet_count"] as? Int) ?? 0
            //favoriteCount
            likesCount = (tweetDictionary["favourite_count"] as? Int) ?? 0

            //name
            userName = tweetDictionary.value(forKeyPath: "user.name") as? String
            //screen name
            screenName = "@" + (tweetDictionary.value(forKeyPath: "user.screen_name") as? String)!
            //profile url
            profileImageURL = tweetDictionary.value(forKeyPath: "user.profile_image_url_https") as? String
        }

        
    }
    
    // create a static class function to return an array of tweets given a array of dictionaries
    class func tweetsWithArray( tweetDictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for aDictionary in tweetDictionaries {
            let tweet = Tweet(tweetDictionary: aDictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
