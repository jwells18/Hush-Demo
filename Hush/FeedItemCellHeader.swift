//
//  FeedItemCellHeader.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import DateToolsSwift

class FeedItemCellHeader: UIView{
    
    var profilePictureView = ProfilePictureView()
    var nameButton = UIButton()
    var timestampLabel = UILabel()
    var followButton = UIButton()
    var moreButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Profile Picture View
        self.setupProfilePictureView()
        
        //Setup Name Button
        self.setupNameButton()
        
        //Setup timestampLabel
        self.setupTimestampLabel()
        
        //Setup Follow Button
        self.setupFollowButton()
        
        //Setup More Button
        self.setupMoreButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupProfilePictureView(){
        self.profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePictureView)
    }
    
    func setupNameButton(){
        self.nameButton.setTitleColor(.darkGray, for: .normal)
        self.nameButton.contentHorizontalAlignment = .left
        self.nameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.nameButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameButton)
    }
    
    func setupTimestampLabel(){
        self.timestampLabel.textColor = .lightGray
        self.timestampLabel.font = UIFont.systemFont(ofSize: 12)
        self.timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timestampLabel)
    }
    
    func setupFollowButton(){
        self.followButton.backgroundColor = HSColor.primary
        self.followButton.setTitle("follow".localized().uppercased(), for: .normal)
        self.followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.followButton.layer.cornerRadius = 5
        self.followButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(followButton)
    }
    
    func setupMoreButton(){
        self.moreButton.setImage(UIImage(named: "more"), for: .normal)
        self.moreButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.moreButton)
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["profilePictureView": profilePictureView, "nameButton": nameButton, "timestampLabel": timestampLabel, "followButton": followButton, "moreButton": moreButton, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[profilePictureView(40)]-[nameButton]-[followButton(80)]-[moreButton(25)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: timestampLabel, attribute: .width, relatedBy: .equal, toItem: nameButton, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: timestampLabel, attribute: .left, relatedBy: .equal, toItem: nameButton, attribute: .left, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: profilePictureView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: profilePictureView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][nameButton][timestampLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: followButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: followButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)])
        self.addConstraints([NSLayoutConstraint.init(item: moreButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: moreButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
    }
    
    func configure(feedItem: FeedItem?, user: User?){
        profilePictureView.configure(user: user)
        nameButton.setTitle(user?.name, for: .normal)
        switch feedItem?.createdAt != nil{
        case true:
            let dateNumber = NSNumber(value: (feedItem?.createdAt)!)
            timestampLabel.text = dateNumber.dateValue().timeAgoSinceNow
        case false:
            timestampLabel.text = ""
        }
    }
}

