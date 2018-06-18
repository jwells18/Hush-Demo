//
//  User.swift
//  Hush
//
//  Created by Justin Wells on 6/11/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class User: NSObject{
    var objectId: String!
    var createdAt = Double()
    var updatedAt = Double()
    var name: String!
    var email: String!
    var image: String!
    var rewardTier: RewardTier!
    var bio: String!
    var likes: Int!
    var followers: Int!
    var following: Int!
}

public enum RewardTier: String{
    case insider = "insider"
    case silver = "silver"
    case gold = "gold"
    case platinum = "platinum"
    case diamond = "diamond"
}
