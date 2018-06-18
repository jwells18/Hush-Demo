//
//  FeedItemCellFooter.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FeedItemCellFooter: UIView{
    
    var likeContainerView = UIView()
    var likeButton = UIButton()
    var likeCountButton = UIButton()
    var commentContainerView = UIView()
    var commentButton = UIButton()
    var commentCountButton = UIButton()
    
    
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
        
        //Setup Like ContainerView
        self.setupLikeContainerView()
        
        //Setup Like Button
        self.setupLikeButton()
        
        //Setup Like Count Button
        self.setupLikeCountButton()
        
        //Setup Comment ContainerView
        self.setupCommentContainerView()
        
        //Setup Comment Button
        self.setupCommentButton()
        
        //Setup Comment Count Button
        self.setupCommentCountButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupLikeContainerView(){
        self.likeContainerView.backgroundColor = .white
        self.likeContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeContainerView)
    }
    
    func setupLikeButton(){
        self.likeButton.setImage(UIImage(named: "like"), for: .normal)
        self.likeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.likeContainerView.addSubview(likeButton)
    }
    
    func setupLikeCountButton(){
        self.likeCountButton.setTitleColor(.darkGray, for: .normal)
        self.likeCountButton.translatesAutoresizingMaskIntoConstraints = false
        self.likeContainerView.addSubview(likeCountButton)
    }
    
    func setupCommentContainerView(){
        self.commentContainerView.backgroundColor = .white
        self.commentContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentContainerView)
    }
    
    func setupCommentButton(){
        self.commentButton.setImage(UIImage(named: "comment"), for: .normal)
        self.commentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.commentButton.translatesAutoresizingMaskIntoConstraints = false
        self.commentContainerView.addSubview(commentButton)
    }
    
    func setupCommentCountButton(){
        self.commentCountButton.setTitleColor(.darkGray, for: .normal)
        self.commentCountButton.translatesAutoresizingMaskIntoConstraints = false
        self.commentContainerView.addSubview(commentCountButton)
    }
    
    func setupConstraints(){
        let spacerViewLikeLeft = UIView()
        spacerViewLikeLeft.isUserInteractionEnabled = false
        spacerViewLikeLeft.translatesAutoresizingMaskIntoConstraints = false
        self.likeContainerView.addSubview(spacerViewLikeLeft)
        let spacerViewLikeRight = UIView()
        spacerViewLikeRight.isUserInteractionEnabled = false
        spacerViewLikeRight.translatesAutoresizingMaskIntoConstraints = false
        self.likeContainerView.addSubview(spacerViewLikeRight)
        let spacerViewCommentLeft = UIView()
        spacerViewCommentLeft.isUserInteractionEnabled = false
        spacerViewCommentLeft.translatesAutoresizingMaskIntoConstraints = false
        self.commentContainerView.addSubview(spacerViewCommentLeft)
        let spacerViewCommentRight = UIView()
        spacerViewCommentRight.isUserInteractionEnabled = false
        spacerViewCommentRight.translatesAutoresizingMaskIntoConstraints = false
        self.commentContainerView.addSubview(spacerViewCommentRight)
        
        let viewDict = ["likeContainerView": likeContainerView, "likeButton": likeButton, "likeCountButton": likeCountButton, "commentContainerView": commentContainerView, "commentButton": commentButton, "commentCountButton": commentCountButton, "spacerViewLikeLeft": spacerViewLikeLeft, "spacerViewLikeRight": spacerViewLikeRight, "spacerViewCommentLeft": spacerViewCommentLeft, "spacerViewCommentRight": spacerViewCommentRight] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[likeContainerView(==commentContainerView)][commentContainerView(==likeContainerView)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.likeContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewLikeLeft(==spacerViewLikeRight)][likeButton(25)]-2-[likeCountButton][spacerViewLikeRight(==spacerViewLikeLeft)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.commentContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewCommentLeft(==spacerViewCommentRight)][commentButton(25)]-2-[commentCountButton][spacerViewCommentRight(==spacerViewCommentLeft)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[likeContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[commentContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.likeContainerView.addConstraints([NSLayoutConstraint.init(item: likeButton, attribute: .centerY, relatedBy: .equal, toItem: self.likeContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.likeContainerView.addConstraints([NSLayoutConstraint.init(item: likeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.likeContainerView.addConstraints([NSLayoutConstraint.init(item: likeCountButton, attribute: .centerY, relatedBy: .equal, toItem: self.likeContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.likeContainerView.addConstraints([NSLayoutConstraint.init(item: likeCountButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.commentContainerView.addConstraints([NSLayoutConstraint.init(item: commentButton, attribute: .centerY, relatedBy: .equal, toItem: self.commentContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.commentContainerView.addConstraints([NSLayoutConstraint.init(item: commentButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.commentContainerView.addConstraints([NSLayoutConstraint.init(item: commentCountButton, attribute: .centerY, relatedBy: .equal, toItem: self.commentContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.commentContainerView.addConstraints([NSLayoutConstraint.init(item: commentCountButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
    }
    
    func configure(feedItem: FeedItem?){
        if feedItem?.likeCount != nil{
            likeCountButton.setTitle(String((feedItem?.likeCount)!), for: .normal)
        }
        else{
            likeCountButton.setTitle("0", for: .normal)
        }
        
        if feedItem?.commentCount != nil{
            commentCountButton.setTitle(String((feedItem?.commentCount)!), for: .normal)
        }
        else{
            commentCountButton.setTitle("0", for: .normal)
        }
    }
}
