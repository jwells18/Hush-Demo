//
//  ShareWithCommunityCell.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ShareWithCommunityCell: UICollectionViewCell{
    
    var imageView = UIImageView()
    var textLabel = UILabel()
    
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
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup TextLabel
        self.setupTextLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupImageView(){
        imageView.image = UIImage(named: "hushIcon")
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 40/2
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    func setupTextLabel(){
        textLabel.text = "shareWithTheCommunity".localized()
        textLabel.textColor = .gray
        textLabel.font = UIFont.boldSystemFont(ofSize: 14)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8)])
        self.addConstraints([NSLayoutConstraint.init(item: self.imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
        self.addConstraints([NSLayoutConstraint.init(item: self.textLabel, attribute: .left, relatedBy: .equal, toItem: self.imageView, attribute: .right, multiplier: 1, constant: 8)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
        self.addConstraints([NSLayoutConstraint.init(item: self.textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.textLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)])
    }
}
