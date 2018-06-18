//
//  FeedItem.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class FeedItem: NSObject{
    var objectId: String!
    var createdAt = Double()
    var updatedAt = Double()
    var image: String!
    var caption: String!
    var userId: String!
    var userName: String!
    var userImage: String!
    var userRewardTier: RewardTier!
    var likeCount: Int!
    var commentCount: Int!
}
