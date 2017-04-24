//
//  User.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/16/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class User: NSObject {

    // models takes care of deserialization, serialization and persistance
    
    var id: Int?
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var profileBackgroundImageUrl: URL?
    var tagline: String?
    
    var tweetCount: Int?
    var followerCount: Int?
    var followingCount: Int?
    
    static let didLogOutNotification = "UserLoggedOut"
    private static let currentUserDataKey = "currentUserData"
    
    init(userDictionary: NSDictionary) {
        dictionary = userDictionary
        id = dictionary["id"] as? Int
        name = userDictionary["name"] as? String
        screenName = userDictionary["screen_name"] as? String
        
        let profileURLString: String? = userDictionary["profile_image_url_https"] as? String
        
        // This is the way to un-wrap the optional
        if let profileURLStringUnwrapped = profileURLString {
            profileURL = URL(string: profileURLStringUnwrapped)
        }
        
        tagline = userDictionary["description"] as? String
        
        let profileBackgroundImageUrlString =  dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundImageUrlString = profileBackgroundImageUrlString {
            profileBackgroundImageUrl = NSURL(string: profileBackgroundImageUrlString)! as URL
        }
        
        tweetCount = dictionary["statuses_count"] as? Int
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int

    }
    
    private let dictionary: NSDictionary
    
    private static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                guard let userData = UserDefaults.standard.object(forKey: currentUserDataKey) as? Data else {
                    return nil
                }
                guard let dictionary = try? JSONSerialization.jsonObject(with: userData, options: []) as? NSDictionary else {
                    return nil
                }
                _currentUser = User(userDictionary: dictionary!)
            }
            return _currentUser
        }
        
        set(user) {
            if let user = user {
                let userData = try? JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                UserDefaults.standard.set(userData, forKey: currentUserDataKey)
            }
            else {
                UserDefaults.standard.set(nil, forKey: currentUserDataKey)
            }
            
            UserDefaults.standard.synchronize()
        }
    }
}
