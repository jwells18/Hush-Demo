//
//  ProfileCell.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate {
    func didPressRewardTierButton(sender: UIButton)
    func didPressFollowButton(sender: UIButton)
    func didPressLikesButton(sender: UIButton)
    func didPressFollowersButton(sender: UIButton)
    func didPressFollowingButton(sender: UIButton)
}

class ProfileCell: UICollectionViewCell{
    
    var profileCellDelegate: ProfileCellDelegate!
    var profilePictureView = ProfilePictureView()
    var nameLabel = UILabel()
    var followButton = UIButton()
    var profileFollowersView = ProfileFollowersView()
    var bioLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup ProfilePictureView
        self.setupProfilePictureView()
        
        //Setup NameLabel
        self.setupNameLabel()
        
        //Setup Follow Button
        self.setupFollowButton()
        
        //Setup Followers View
        self.setupProfileFollowersView()
        
        //Setup Bio Label
        self.setupBioLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupProfilePictureView(){
        profilePictureView.rewardTierButton.addTarget(self, action: #selector(self.rewardTierButtonPressed), for: .touchUpInside)
        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePictureView)
    }
    
    func setupNameLabel(){
        nameLabel.textColor = .darkGray
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setupFollowButton(){
        followButton.backgroundColor = HSColor.secondary
        followButton.addTarget(self, action: #selector(self.followButtonPressed), for: .touchUpInside)
        followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(followButton)
    }
    
    func setupProfileFollowersView(){
        profileFollowersView.likesCountButton.addTarget(self, action: #selector(self.likesButtonPressed), for: .touchUpInside)
        profileFollowersView.likesButton.addTarget(self, action: #selector(self.likesButtonPressed), for: .touchUpInside)
        profileFollowersView.followersCountButton.addTarget(self, action: #selector(self.followersButtonPressed), for: .touchUpInside)
        profileFollowersView.followersButton.addTarget(self, action: #selector(self.followersButtonPressed), for: .touchUpInside)
        profileFollowersView.followingCountButton.addTarget(self, action: #selector(self.followingButtonPressed), for: .touchUpInside)
        profileFollowersView.followingButton.addTarget(self, action: #selector(self.followingButtonPressed), for: .touchUpInside)
        profileFollowersView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileFollowersView)
    }
    
    func setupBioLabel(){
        bioLabel.backgroundColor = HSColor.faintGray
        bioLabel.textColor = .darkGray
        bioLabel.textAlignment = .center
        bioLabel.numberOfLines = 3
        bioLabel.font = UIFont.boldSystemFont(ofSize: 14)
        bioLabel.layer.cornerRadius = 5
        bioLabel.layer.borderColor = UIColor.lightGray.cgColor
        bioLabel.layer.borderWidth = 0.5
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bioLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        followButton.layer.cornerRadius = followButton.frame.height/2
    }
    
    func setupConstraints(){
        let viewDict = ["profilePictureView": profilePictureView, "nameLabel": nameLabel, "followButton": followButton, "profileFollowersView": profileFollowersView, "bioLabel": bioLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.profilePictureView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.profilePictureView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 175)])
        self.addConstraints([NSLayoutConstraint.init(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.followButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.followButton, attribute: .width, relatedBy: .equal, toItem: profilePictureView, attribute: .width, multiplier: 1.25, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.profileFollowersView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.profileFollowersView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.bioLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.bioLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.9, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[profilePictureView(175)][nameLabel(30)]-25-[followButton(45)]-15-[profileFollowersView(60)]-15-[bioLabel(75)]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(user: User?){
        profilePictureView.configure(user: user)
        profileFollowersView.configure(user: user)
        nameLabel.text = user?.name
        switch user?.bio == nil{
        case true:
            bioLabel.text = "noBio".localized().uppercased()
            bioLabel.textColor = .gray
            break
        case false:
            switch (user?.bio.characters.count)! > 0 {
            case true:
                bioLabel.text = user?.bio
                bioLabel.textColor = .darkGray
            case false:
                bioLabel.text = "noBio".localized().uppercased()
                bioLabel.textColor = .gray
            }
        }
        followButton.setTitle("follow".localized().uppercased(), for: .normal)
    }
    
    //Button Delegate
    func rewardTierButtonPressed(sender: UIButton){
        profileCellDelegate.didPressRewardTierButton(sender: sender)
    }
    
    func followButtonPressed(sender: UIButton){
        profileCellDelegate.didPressFollowButton(sender: sender)
    }
    
    func likesButtonPressed(sender: UIButton){
        profileCellDelegate.didPressLikesButton(sender: sender)
    }
    
    func followersButtonPressed(sender: UIButton){
        profileCellDelegate.didPressFollowersButton(sender: sender)
    }
    
    func followingButtonPressed(sender: UIButton){
        profileCellDelegate.didPressFollowingButton(sender: sender)
    }
}
