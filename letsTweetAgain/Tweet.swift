//
//  Tweet.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var retweetCount: Int = 0
    var likesCount: Int = 0
    var timeStamp: Date?
    
    var user: NSDictionary?
    var profileImageURL: String? {
        get {
            return user?["profile_image_url_https"] as? String
        }
    }
    
    var userName: String? {
        get {
            return user?["name"] as? String
        }
    }
    
    init (tweetDictionary: NSDictionary){
        text = tweetDictionary["text"] as? String
        retweetCount = (tweetDictionary["retweet_count"] as? Int) ?? 0
        likesCount = (tweetDictionary["favourites_count"] as? Int) ?? 0
        user = tweetDictionary["user"] as? NSDictionary
        
        let timeStampString = tweetDictionary["created_at"] as? String
        
        if let timeStampStringUnwrapped = timeStampString {
            let timeStampFormatter = DateFormatter()
            timeStampFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = timeStampFormatter.date(from: timeStampStringUnwrapped)
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
