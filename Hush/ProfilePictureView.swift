//
//  ProfilePictureView.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

class ProfilePictureView: UIView{
    
    var profileButton = UIButton()
    var rewardTierButton = UIButton()
    
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
        
        //Setup Profile Button
        self.setupProfileButton()
        
        //Setup RewardTier Button
        self.setupRewardTierButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupProfileButton(){
        self.profileButton.clipsToBounds = true
        self.profileButton.layer.borderWidth = 0.5
        self.profileButton.layer.borderColor = UIColor.lightGray.cgColor
        self.profileButton.layer.cornerRadius = 40/2
        self.profileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileButton)
    }
    
    func setupRewardTierButton(){
        rewardTierButton.isHidden = true
        rewardTierButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rewardTierButton)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: profileButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: profileButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.7, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rewardTierButton, attribute: .centerX, relatedBy: .equal, toItem: profileButton, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rewardTierButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0)])
        
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: profileButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: profileButton, attribute: .height, relatedBy: .equal, toItem: profileButton, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rewardTierButton, attribute: .centerY, relatedBy: .equal, toItem: profileButton, attribute: .bottom, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: rewardTierButton, attribute: .height, relatedBy: .equal, toItem: rewardTierButton, attribute: .width, multiplier: 1, constant: 0)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileButton.layer.cornerRadius = profileButton.frame.width/2
    }
    
    func configure(user: User?){
        if user?.image != nil{
            profileButton.sd_setImage(with: URL(string: (user?.image)!), for: .normal, placeholderImage: UIImage(named: "hushPlaceholder"), options: SDWebImageOptions.init(rawValue: 0), completed: nil)
        }
        else{
            profileButton.setImage(UIImage(named: "hushIcon"), for: .normal)
        }
        if user?.rewardTier != nil{
            rewardTierButton.isHidden = false
            switch (user?.rewardTier)!{
            case .insider:
                rewardTierButton.setImage(UIImage(named: "rewardTierInsider"), for: .normal)
            case .silver:
                rewardTierButton.setImage(UIImage(named: "rewardTierSilver"), for: .normal)
            case .gold:
                rewardTierButton.setImage(UIImage(named: "rewardTierGold"), for: .normal)
            case .platinum:
                rewardTierButton.setImage(UIImage(named: "rewardTierPlatinum"), for: .normal)
            case .diamond:
                rewardTierButton.setImage(UIImage(named: "rewardTierDiamond"), for: .normal)
            }
        }
        else{
            rewardTierButton.isHidden = true
        }
    }
}
