//
//  AccountSectionFooter.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class AccountSectionFooter: UIView{
    
    var containerView = UIView()
    var leftLabel = UILabel()
    var imageView = UIImageView()
    var rightLabel = UILabel()
    
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
        
        //Setup ContainerView
        self.setupContainerView()
        
        //Setup Left Label
        self.setupLeftLabel()
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup Right Label
        self.setupRightLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupContainerView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
    }
    
    func setupLeftLabel(){
        leftLabel.text = "leftAccountFooterText".localized().uppercased()
        leftLabel.textColor = .lightGray
        leftLabel.font = UIFont.boldSystemFont(ofSize: 12)
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(leftLabel)
    }
    
    func setupImageView(){
        imageView.image = UIImage(named: "loveSmallFilled")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(imageView)
    }
    
    func setupRightLabel(){
        rightLabel.text = "rightAccountFooterText".localized().uppercased()
        rightLabel.textColor = .lightGray
        rightLabel.font = UIFont.boldSystemFont(ofSize: 12)
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(rightLabel)
    }
    
    func setupConstraints(){
        let viewDict = ["containerView": containerView, "leftLabel": leftLabel, "imageView": imageView, "rightLabel": rightLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.containerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leftLabel]-2-[imageView(16)]-2-[rightLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: leftLabel, attribute: .height, relatedBy: .equal, toItem: self.containerView, attribute: .height, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: leftLabel, attribute: .centerY, relatedBy: .equal, toItem: self.containerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self.containerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: rightLabel, attribute: .height, relatedBy: .equal, toItem: self.containerView, attribute: .height, multiplier: 1, constant: 0)])
        self.containerView.addConstraints([NSLayoutConstraint.init(item: rightLabel, attribute: .centerY, relatedBy: .equal, toItem: self.containerView, attribute: .centerY, multiplier: 1, constant: 0)])
    }
}
