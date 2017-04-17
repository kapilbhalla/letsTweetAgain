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
    
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var tagline: String?
    
    init(userDictionary: NSDictionary) {
        name = userDictionary["name"] as? String
        screenName = userDictionary["screen_name"] as? String
        
        let profileURLString: String? = userDictionary["profile_image_url_https"] as? String
        
        // This is the way to un-wrap the optional
        if let profileURLStringUnwrapped = profileURLString {
            profileURL = URL(string: profileURLStringUnwrapped)
        }
        
        tagline = userDictionary["description"] as? String
    }
}
