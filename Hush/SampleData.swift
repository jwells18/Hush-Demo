//
//  SampleData.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase

//MARK: Sample Products
func uploadSampleProducts(){
    //Create Sample Users
    for i in stride(from: 0, to: productNames.count, by: 1) {
        let product = Product()
        product.company = productCompanies[i]
        product.name = productNames[i]
        product.price = productPrices[i]
        product.details = productDetails[i]
        product.boughtCount = productBoughtCount[i]
        product.viewingCount = productViewingCount[i]
        product.category = productCategories[i]
        
        //Upload User to User Database
        let productManager = ProductManager()
        productManager.upload(product: product, image: productImages[i], completionHandler: { (completed) in
            if completed{
                print("\(product.name) uploaded successfully")
            }
            else{
                print("\(product.name) not uploaded")
            }
        })
    }
}

//Sample Product Raw Data
let productNames = ["Atlantis Eyeshadow Palette", "Athena Eyeshadow Palette", "Aphrodite Eyeshadow Palette", "Arabesque Eyeshadow Palette", "Rose Highlight Palette", "Sahara + Amazonia Bundle", "Amazonia Eyeshadow Palette", "Sahara Eyeshadow Palette", "Retro Love Eyeshadow Palette", "After Hours Eyeshadow Palette"]
let productCompanies = ["Face Candy", "Bad Habit", "Bad Habit", "Bad Habit", "Bad Habit", "Face Candy", "Face Candy", "Face Candy", "Bad Habit", "Bad Habit"]
let productPrices = [14.00, 14.00, 14.00, 16.00, 12.00, 20.00, 12.00, 12.00, 12.00, 10.00]
let productImages = [UIImage(named: "hushProduct1"), UIImage(named: "hushProduct2"), UIImage(named: "hushProduct3"), UIImage(named: "hushProduct4"), UIImage(named: "hushProduct5"), UIImage(named: "hushProduct6"), UIImage(named: "hushProduct7"), UIImage(named: "hushProduct8"), UIImage(named: "hushProduct9"), UIImage(named: "hushProduct10")]
let productDetails = ["Explore a sea of possibilities with the 12 cool toned shades of Atlantis. With an ultra pigmented smooth formula this collection features 7 mattes and 5 shimmer shades. The teals, turquoises, and rich blues of this palette will give you the perfect splash of color!", "Inspired by the Greek goddess of wisdom and war, this 18 shade collection will inspire with its wide range of shades and innovative formulas. Featuring four unique textures, Athena has 8 soft and bold mattes, 6 buttery pearled shimmers, 3 shade shifting duo chrome toppers, and one eye-catching glitter.", "Inspired by the Greek goddess of love and beauty, this eyeshadow palette features 18 shades in a range of deeply saturated mattes, richly textured metallics, and uniquely pressed pearls. Cruelty-free.", "Embrace your dancer within while exploring the 14 shades of Arabesque. Featuring 9 silky, pigmented mattes and 5 eye-catching shimmers in a range of iridescent, satin, and metallic finishes this eyeshadow collection will create sophisticated eye looks that will elevate and uplift your day and night creations.", "Introducing Rosé — this six-color highlight collection features an exclusive formula that is creamy, intensely luminous, and easy to blend. The shimmery gold and pinks tones of Rosé celebrate our favorite summer sip. Cruelty-free.", "Amazonia - Get the eye of the tiger with this wild palette. Featuring 14 shades including 8 creamy and pigment-packed mattes, 5 buttery metallic shimmers, and 1 glitter-infused satin, Amazonia will give you looks fit for a queen of the jungle.\n\nSahara - Unlock the looks of the Sahara with this heated palette. Features 14 shades with 8 smooth and pigmented mattes, 5 striking shimmers, and 1 shade shifting duo-chrome.\n\nCruelty-free.", "Get the eye of the tiger with this wild palette. Featuring 14 shades including 8 creamy and pigment-packed mattes, 5 buttery metallic shimmers, and 1 glitter-infused satin, Amazonia will give you looks fit for a queen of the jungle. Cruelty-free.", "Unlock the looks of the Sahara with this heated palette. Features 14 shades with 8 smooth and pigmented mattes, 5 striking shimmers, and 1 shade shifting duo-chrome. Cruelty-free.", "An ultimate throwback to the 1960's, this 14-shade eyeshadow palette features 11 velvety mattes in bold, edgy shades, 2 duo-chromes, and a metallic bronze. Cruelty-Free. This edition features the same formula you love with an updated and improved packaging featuring a glossy interior and soft touch exterior.", "Featuring 6 smooth, pigmented mattes and 3 buttery shimmers, After Hours' rusty mauve shades will create subtle natural looks elevating your smokey eye to the next level."]
let productBoughtCount = [9200, 514400, 510000, 26000, 133600, 58000, 15200, 13900, 200800, 46900]
let productViewingCount = [27, 20, 18, 43, 25, 18, 31, 49, 3, 20]
let productCategories = ["featured", "featured", "featured", "featured", "featured", "featured", "featured", "featured", "featured", "featured"]

//MARK: Sample Users
func uploadSampleUsers(){
    //Create Sample Users
    for i in stride(from: 0, to: userNames.count, by: 1) {
        let user = User()
        user.name = userNames[i]
        user.email = userEmails[i]
        user.rewardTier = userRewardTier[i]
        user.bio = userBio[i]
        user.likes = userLikes[i]
        user.followers = userFollowers[i]
        user.following = userFollowing[i]
        
        //Upload User to User Database
        let userManager = UserManager()
        userManager.create(user: user, completionHandler: { (completed) in
            if completed{
                print("\(user.name) uploaded successfully")
            }
            else{
                print("\(user.name) not uploaded")
            }
        })
    }
}

//Sample User Raw Data
let userNames = ["sarah", "michelle", "barbara", "jessica", "danielle", "claire", "tiffany", "ashley"]
let userEmails = ["ssmith@gmail.com", "mmiller@gmail.com", "bbrown@gmail.com", "jjones@gmail.com", "ddavis@gmail.com", "cclark@gmail.com", "tthompson@gmail.com", "aanderson@gmail.com"]
let userRewardTier = [RewardTier.insider, .gold, .insider, .silver, .insider, .gold, .diamond, .insider]
let userBio = ["I ❤️ MAKEUP", "Sometimes I do some snazzy makeup!!", "", "Makeup enthusiast from Texas 🌵", "", "💄 Makeup Junkie 💄Beauty Vlogger 💄 YouTuber", "Military Wife, Mom of two beautiful kids, Makeup, Harry Potter, Owl & Cat lover", "Just a girl getting and being inspired by the world of makeup. 👄💄"]
let userLikes = [795, 111, 29, 322, 498, 22, 117, 21]
let userFollowers = [458, 79, 5, 172, 889, 24, 375, 3]
let userFollowing = [38, 132, 24, 5, 767, 91, 78, 6]


//MARK: Sample Feed Items
func uploadSampleFeedItems(){
    //Create Sample FeedItem
    for i in stride(from: 0, to: feedItemCaptions.count, by: 1) {
        let feedItem = FeedItem()
        feedItem.caption = feedItemCaptions[i]
        feedItem.userId = feedItemUserIds[i]
        feedItem.likeCount = feedItemLikeCount[i]
        feedItem.commentCount = feedItemCommentCount[i]
        feedItem.userName = feedItemUserNames[i]
        feedItem.userRewardTier = feedItemRewardTiers[i]
        
        //Upload feedItem to feedItem Database
        let feedItemManager = FeedItemManager()
        feedItemManager.create(feedItem: feedItem, image: feedItemImages[i], completionHandler: { (completed) in
            if completed{
                print("Post uploaded successfully")
            }
            else{
                print("Post not uploaded")
            }
        })
    }
}

//Sample Feed Item Raw Data
let feedItemCaptions = ["I tried something different with my cheek bones today. Let me know what you think?", "My pool side look today.", "", "My Atlantis palette just arrived. I am SOOOO excited to try it out.", "", "", "Athena by Bad Habit package just landed in my mailbox. Like and comment your thoughts on this product.", ""]
let feedItemUserIds = ["-LEpfJXD-IeZ4DGSz8u2", "-LEpfJXmR30bAHo3gBBL", "-LEpfJXo1v_MdH00OgQV", "-LEpfJXo1v_MdH00OgQW", "-LEpfJXqiJiSRxlcvv-l", "-LEpfJXrYN6x1DhUMdEv", "-LEpfJXrYN6x1DhUMdEw", "-LEpfJXsoi46kg1Gt6Zy"]
let feedItemImages = [UIImage(named: "hushFeedPhoto1"), UIImage(named: "hushFeedPhoto2"), UIImage(named: "hushFeedPhoto3"), UIImage(named: "hushFeedPhoto4"), UIImage(named: "hushFeedPhoto5"), UIImage(named: "hushFeedPhoto6"), UIImage(named: "hushFeedPhoto7"), UIImage(named: "hushFeedPhoto8")]
let feedItemLikeCount = [15, 4, 59, 34, 89, 113, 6, 72]
let feedItemCommentCount = [0, 3, 14, 2, 7, 25, 0, 8]
let feedItemUserNames = ["sarah", "michelle", "barbara", "jessica", "danielle", "claire", "tiffany", "ashley"]
let feedItemRewardTiers = [RewardTier.insider, .gold, .insider, .silver, .insider, .gold, .diamond, .insider]

