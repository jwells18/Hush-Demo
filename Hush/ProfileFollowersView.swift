//
//  ProfileFollowersView.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProfileFollowersView: UIView{
    
    var likesContainerView = UIView()
    var likesCountButton = UIButton()
    var likesButton = UIButton()
    var followersContainerView = UIView()
    var followersCountButton = UIButton()
    var followersButton = UIButton()
    var followingContainerView = UIView()
    var followingCountButton = UIButton()
    var followingButton = UIButton()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Likes ContainerView
        self.setupLikesContainerView()
        
        //Setup Likes Count Button
        self.setupLikesCountButton()
        
        //Setup Likes Button
        self.setupLikesButton()
        
        //Setup Followers ContainerView
        self.setupFollowersContainerView()
        
        //Setup Followers Count Button
        self.setupFollowersCountButton()
        
        //Setup Followers Button
        self.setupFollowersButton()
        
        //Setup Following ContainerView
        self.setupFollowingContainerView()
        
        //Setup Following Count Button
        self.setupFollowingCountButton()
        
        //Setup Following Button
        self.setupFollowingButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupLikesContainerView(){
        self.likesContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likesContainerView)
    }
    
    func setupLikesCountButton(){
        self.likesCountButton.setTitleColor(.darkGray, for: .normal)
        self.likesCountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.likesCountButton.translatesAutoresizingMaskIntoConstraints = false
        self.likesContainerView.addSubview(likesCountButton)
    }
    
    func setupLikesButton(){
        self.likesButton.setTitle("likes".localized().uppercased(), for: .normal)
        self.likesButton.setTitleColor(.darkGray, for: .normal)
        self.likesButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.likesButton.translatesAutoresizingMaskIntoConstraints = false
        self.likesContainerView.addSubview(likesButton)
    }
    
    func setupFollowersContainerView(){
        self.followersContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(followersContainerView)
    }
    
    func setupFollowersCountButton(){
        self.followersCountButton.setTitleColor(.darkGray, for: .normal)
        self.followersCountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.followersCountButton.translatesAutoresizingMaskIntoConstraints = false
        self.followersContainerView.addSubview(followersCountButton)
    }
    
    func setupFollowersButton(){
        self.followersButton.setTitle("followers".localized().uppercased(), for: .normal)
        self.followersButton.setTitleColor(.darkGray, for: .normal)
        self.followersButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.followersButton.translatesAutoresizingMaskIntoConstraints = false
        self.followersContainerView.addSubview(followersButton)
    }
    
    func setupFollowingContainerView(){
        self.followingContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(followingContainerView)
    }
    
    func setupFollowingCountButton(){
        self.followingCountButton.setTitleColor(.darkGray, for: .normal)
        self.followingCountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.followingCountButton.translatesAutoresizingMaskIntoConstraints = false
        self.followingContainerView.addSubview(followingCountButton)
    }
    
    func setupFollowingButton(){
        self.followingButton.setTitle("following".localized().uppercased(), for: .normal)
        self.followingButton.setTitleColor(.darkGray, for: .normal)
        self.followingButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.followingButton.translatesAutoresizingMaskIntoConstraints = false
        self.followingContainerView.addSubview(followingButton)
    }
    
    func setupConstraints(){
        
        let spacerViewLikesTop = UIView()
        spacerViewLikesTop.isUserInteractionEnabled = false
        spacerViewLikesTop.translatesAutoresizingMaskIntoConstraints = false
        self.likesContainerView.addSubview(spacerViewLikesTop)
        let spacerViewLikesBottom = UIView()
        spacerViewLikesBottom.isUserInteractionEnabled = false
        spacerViewLikesBottom.translatesAutoresizingMaskIntoConstraints = false
        self.likesContainerView.addSubview(spacerViewLikesBottom)
        let spacerViewFollowersTop = UIView()
        spacerViewFollowersTop.isUserInteractionEnabled = false
        spacerViewFollowersTop.translatesAutoresizingMaskIntoConstraints = false
        self.followersContainerView.addSubview(spacerViewFollowersTop)
        let spacerViewFollowersBottom = UIView()
        spacerViewFollowersBottom.isUserInteractionEnabled = false
        spacerViewFollowersBottom.translatesAutoresizingMaskIntoConstraints = false
        self.followersContainerView.addSubview(spacerViewFollowersBottom)
        let spacerViewFollowingTop = UIView()
        spacerViewFollowingTop.isUserInteractionEnabled = false
        spacerViewFollowingTop.translatesAutoresizingMaskIntoConstraints = false
        self.followingContainerView.addSubview(spacerViewFollowingTop)
        let spacerViewFollowingBottom = UIView()
        spacerViewFollowingBottom.isUserInteractionEnabled = false
        spacerViewFollowingBottom.translatesAutoresizingMaskIntoConstraints = false
        self.followingContainerView.addSubview(spacerViewFollowingBottom)
        
        let viewDict = ["likesContainerView": likesContainerView, "likesCountButton": likesCountButton, "likesButton": likesButton, "followersContainerView": followersContainerView, "followersCountButton": followersCountButton, "followersButton": followersButton, "followingContainerView": followingContainerView, "followingCountButton": followingCountButton, "followingButton": followingButton, "spacerViewLikesTop": spacerViewLikesTop, "spacerViewLikesBottom": spacerViewLikesBottom, "spacerViewFollowersTop": spacerViewFollowersTop, "spacerViewFollowersBottom": spacerViewFollowersBottom, "spacerViewFollowingTop": spacerViewFollowingTop, "spacerViewFollowingBottom": spacerViewFollowingBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[likesContainerView(==followersContainerView)][followersContainerView(==followingContainerView)][followingContainerView(==likesContainerView)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.likesContainerView.addConstraints([NSLayoutConstraint.init(item: likesCountButton, attribute: .centerX, relatedBy: .equal, toItem: self.likesContainerView, attribute: .centerX, multiplier: 1, constant: 0)])
        self.likesContainerView.addConstraints([NSLayoutConstraint.init(item: likesButton, attribute: .centerX, relatedBy: .equal, toItem: self.likesContainerView, attribute: .centerX, multiplier: 1, constant: 0)])
        self.followersContainerView.addConstraints([NSLayoutConstraint.init(item: followersCountButton, attribute: .centerX, relatedBy: .equal, toItem: self.followersContainerView, attribute: .centerX, multiplier: 1, constant: 0)])
        self.followersContainerView.addConstraints([NSLayoutConstraint.init(item: followersButton, attribute: .centerX, relatedBy: .equal, toItem: self.followersContainerView, attribute: .centerX, multiplier: 1, constant: 0)])
        self.followingContainerView.addConstraints([NSLayoutConstraint.init(item: followingCountButton, attribute: .centerX, relatedBy: .equal, toItem: self.followingContainerView, attribute: .centerX, multiplier: 1, constant: 0)])
        self.followingContainerView.addConstraints([NSLayoutConstraint.init(item: followingButton, attribute: .centerX, relatedBy: .equal, toItem: self.followingContainerView, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: likesContainerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: followersContainerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: followingContainerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: likesContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: followersContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: followingContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
        self.likesContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewLikesTop(==spacerViewLikesBottom)][likesCountButton][likesButton][spacerViewLikesBottom(==spacerViewLikesTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.followersContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewFollowersTop(==spacerViewFollowersBottom)][followersCountButton][followersButton][spacerViewFollowersBottom(==spacerViewFollowersTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.followingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewFollowingTop(==spacerViewFollowingBottom)][followingCountButton][followingButton][spacerViewFollowingBottom(==spacerViewFollowingTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        
    }
    
    func configure(user: User?){
        if user?.likes != nil{
            likesCountButton.setTitle(String((user?.likes)!), for: .normal)
        }
        else{
            likesCountButton.setTitle("0", for: .normal)
        }
        
        if user?.followers != nil{
            followersCountButton.setTitle(String((user?.followers)!), for: .normal)
        }
        else{
            followersCountButton.setTitle("0", for: .normal)
        }
        
        if user?.following != nil{
            followingCountButton.setTitle(String((user?.following)!), for: .normal)
        }
        else{
            followingCountButton.setTitle("0", for: .normal)
        }
    }
}
