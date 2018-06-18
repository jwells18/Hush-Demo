//
//  FeedItemManager.swift
//  Hush
//
//  Created by Justin Wells on 6/11/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FeedItemManager: NSObject{
    
    var ref: DatabaseReference!
    
    func create(feedItem: FeedItem, image: UIImage?, completionHandler:@escaping (Bool) -> Void) {
        if image != nil {
            //Convert Image to Data
            let imageData = UIImageJPEGRepresentation(image!, 0.7)
            //Save Item Image
            let uuid = UUID().uuidString
            let imageFileName = String(format: "%@.jpeg", uuid)
            let storageRef = Storage.storage().reference()
            _ = storageRef.child(feedItemDatabase).child(feedItem.userId).child(imageFileName).putData(imageData!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL: URL = metadata.downloadURL()!
                
                //Upload FeedItem
                self.uploadFeedItem(feedItem: feedItem, imageURL: downloadURL, completionHandler: { (isCompleted) in
                    completionHandler(isCompleted)
                })
            }
        }
        else{
            //Upload FeedItem
            self.uploadFeedItem(feedItem: feedItem, imageURL: nil, completionHandler: { (isCompleted) in
                completionHandler(isCompleted)
            })
        }
    }
    
    func uploadFeedItem(feedItem: FeedItem, imageURL: URL?,  completionHandler:@escaping (Bool) -> Void){
        self.ref = Database.database().reference()
        var feedItemData = Dictionary<String, Any>()
        feedItemData["objectId"] = self.ref.childByAutoId().key
        feedItemData["createdAt"] = ServerValue.timestamp()
        feedItemData["updatedAt"] = ServerValue.timestamp()
        feedItemData["image"] = imageURL?.absoluteString
        feedItemData["caption"] = feedItem.caption
        feedItemData["likeCount"] = feedItem.likeCount
        feedItemData["commentCount"] = feedItem.commentCount
        feedItemData["userId"] = feedItem.userId
        feedItemData["userName"] = feedItem.userName
        feedItemData["userImage"] = feedItem.userImage
        feedItemData["userRewardTier"] = feedItem.userRewardTier.rawValue
        
        self.ref.child(feedItemDatabase).child(feedItemData["objectId"] as! String).setValue(feedItemData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                completionHandler(false)
            }
            else{
                completionHandler(true)
            }
        }
    }
    
    func downloadFeedItems(uid: String?, completionHandler:@escaping ([FeedItem]) -> Void){
        var feedItems = [FeedItem]()
        ref = Database.database().reference().child(feedItemDatabase)
        var query = DatabaseQuery()
        query = ref.queryOrdered(byChild: "userId").queryEqual(toValue: uid).queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(feedItems)
                return
            }
            
            for child in snapshot.children{
                //Create FeedItem
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let feedItem = self.createFeedItem(rawData: rawData)
                //TODO: Update to current userId when user system is live
                if(feedItem.userId != "sampleUser1"/*sampleUser.objectId*/){
                    feedItems.insert(feedItem, at: 0)
                }
            }
            completionHandler(feedItems)
        })
    }
    
    func downloadFriendsFeedItems(endValue: Double?, completionHandler:@escaping ([FeedItem]) -> Void){
        var feedItems = [FeedItem]()
        ref = Database.database().reference().child(feedItemDatabase)
        var query = DatabaseQuery()
        query = ref.queryOrdered(byChild: "createdAt").queryEnding(atValue: endValue).queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(feedItems)
                return
            }
            
            for child in snapshot.children{
                //Create FeedItem
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let feedItem = self.createFeedItem(rawData: rawData)
                //TODO: Update to current userId when user system is live
                if(feedItem.userId != "sampleUser1"/*sampleUser.objectId*/){
                    feedItems.insert(feedItem, at: 0)
                }
            }
            completionHandler(feedItems)
        })
    }
    
    func downloadTrendingFeedItems(endValue: Double?, completionHandler:@escaping ([FeedItem]) -> Void){
        var feedItems = [FeedItem]()
        ref = Database.database().reference().child(feedItemDatabase)
        var query = DatabaseQuery()
        query = ref.queryOrdered(byChild: "createdAt").queryEnding(atValue: endValue).queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(feedItems)
                return
            }
            
            for child in snapshot.children{
                //Create FeedItem
                let childSnapshot = child as? DataSnapshot
                
                let rawData = childSnapshot?.value as! [String: Any]
                let feedItem = self.createFeedItem(rawData: rawData)
                //TODO: Update to current userId when user system is live
                if(feedItem.userId != "sampleUser1"/*sampleUser.objectId*/){
                    feedItems.insert(feedItem, at: 0)
                }
            }
            
            completionHandler(feedItems)
        })
    }
    
    func createFeedItem(rawData: [String: Any]) -> FeedItem{
        let feedItem = FeedItem()
        feedItem.objectId = rawData["objectId"] as? String
        feedItem.createdAt = rawData["createdAt"] as! Double
        feedItem.updatedAt = rawData["updatedAt"] as! Double
        feedItem.userId = rawData["userId"] as? String
        feedItem.userName = rawData["userName"] as? String
        feedItem.userImage = rawData["userImage"] as? String
        let rewardTier = rawData["userRewardTier"] as? String
        if rewardTier != nil{
            feedItem.userRewardTier = RewardTier(rawValue: rewardTier!)
        }
        feedItem.caption = rawData["caption"] as? String
        feedItem.image = rawData["image"] as? String
        feedItem.likeCount = rawData["likeCount"] as? Int
        feedItem.commentCount = rawData["commentCount"] as? Int

        return feedItem
    }
}
