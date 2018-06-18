//
//  UserManager.swift
//  Hush
//
//  Created by Justin Wells on 6/12/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase

class UserManager: NSObject{
    
    var ref: DatabaseReference!
    
    func create(user: User, completionHandler:@escaping (Bool) -> Void) {
        //Create New User
        let ref = Database.database().reference()
        var userData = Dictionary<String, Any>()
        userData["objectId"] = ref.childByAutoId().key
        userData["createdAt"] = ServerValue.timestamp()
        userData["updatedAt"] = ServerValue.timestamp()
        userData["name"] = user.name
        userData["email"] = user.email
        userData["image"] = user.image
        userData["rewardTier"] = user.rewardTier.rawValue
        userData["bio"] = user.bio
        userData["likes"] = user.likes
        userData["followers"] = user.followers
        userData["following"] = user.following
        ref.child(userDatabase).child(userData["objectId"] as! String).setValue(userData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading user")
            }
        }
    }
    
    func downloadUser(uid: String, completionHandler:@escaping (User?) -> Void){
        ref = Database.database().reference().child(userDatabase).child(uid)
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() { return }
            let rawData = snapshot.value as! [String: Any]
            let user = self.createUser(rawData: rawData)
            completionHandler(user)
        })
    }
    
    func downloadUsers(endValue: Double?, completionHandler:@escaping ([User]) -> Void){
        var users = [User]()
        ref = Database.database().reference().child(userDatabase)
        var query = DatabaseQuery()
        query = ref.queryOrdered(byChild: "createdAt").queryEnding(atValue: endValue).queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(users)
                return
            }
            
            for child in snapshot.children{
                //Create FeedItem
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let user = self.createUser(rawData: rawData)
                //TODO: Update to current userId when user system is live
                if(user.objectId != "sampleUser1"/*sampleUser.objectId*/){
                    users.insert(user, at: 0)
                }
            }
            completionHandler(users)
        })
    }
    
    func createUser(rawData: [String: Any]) -> User{
        let user = User()
        user.objectId = rawData["objectId"] as? String
        user.createdAt = rawData["createdAt"] as! Double
        user.updatedAt = rawData["updatedAt"] as! Double
        user.name = rawData["name"] as! String
        user.email = rawData["email"] as? String
        user.image = rawData["image"] as? String
        let rewardTier = rawData["rewardTier"] as? String
        if rewardTier != nil{
            user.rewardTier = RewardTier(rawValue: rewardTier!)
        }
        user.bio = rawData["bio"] as? String
        user.likes = rawData["likes"] as? Int
        user.followers = rawData["followers"] as? Int
        user.following = rawData["following"] as? Int
        
        return user
    }
}
