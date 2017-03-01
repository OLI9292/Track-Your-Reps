//
//  Members.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/1/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation

class Member {
    var name: String
    var party: Party
    var twitterID: String
    var phone: Int
    
    init(name: String, party: Party, twitterID: String, phone: Int) {
        self.name = name
        self.party = party
        self.twitterID = twitterID
        self.phone = phone
    }
    
}

enum Party: String
{
    case Democrat = "D"
    case Republican = "R"
    case Independent = "I"
}
