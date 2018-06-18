//
//  FeedItemCell.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

protocol FeedItemCellDelegate {
    func relayDidPressProfileButton(sender: UIButton)
    func relayDidPressNameButton(sender: UIButton)
    func relayDidPressFollowButton(sender: UIButton)
    func relayDidPressMoreButton(sender: UIButton)
    func relayDidPressImageButton(sender: UIButton, doubleTap: Bool)
    func relayDidPressLikeButton(sender: UIButton)
    func relayDidPressCommentButton(sender: UIButton)
}

class FeedItemCell: UICollectionViewCell{
    
    var feedItemCellDelegate: FeedItemCellDelegate!
    var header = FeedItemCellHeader()
    var textLabel = UILabel()
    var imageView = HSImageButton()
    var footer = FeedItemCellFooter()
    
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
        
        //Setup Header
        header.profilePictureView.profileButton.addTarget(self, action: #selector(self.profileButtonPressed), for: .touchUpInside)
        header.nameButton.addTarget(self, action: #selector(self.nameButtonPressed), for: .touchUpInside)
        header.followButton.addTarget(self, action: #selector(self.followButtonPressed), for: .touchUpInside)
        header.moreButton.addTarget(self, action: #selector(self.moreButtonPressed), for: .touchUpInside)
        header.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(header)

        //Setup Image Button
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Add Double Tap Gesture Recognizers to imageView
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewDoubleTapped))
        doubleTapGesture.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(doubleTapGesture)
        
        //Add Single Tap Gesture Recognizers to imageView
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewSingleTapped))
        singleTapGesture.numberOfTapsRequired = 1
        self.imageView.addGestureRecognizer(singleTapGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
        
        //Setup TextLabel
        textLabel.textColor = .gray
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
        
        //Setup Footer
        footer.likeButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
        footer.likeCountButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
        footer.commentButton.addTarget(self, action: #selector(self.commentButtonPressed), for: .touchUpInside)
        footer.commentCountButton.addTarget(self, action: #selector(self.commentButtonPressed), for: .touchUpInside)
        footer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(footer)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["header": header, "textLabel": textLabel, "imageView": imageView, "footer": footer] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: header, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: header, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: textLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: textLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: footer, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: footer, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[header(60)][textLabel][imageView][footer(60)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
    }
    
    func configure(feedItem: FeedItem?, user: User?){
        header.configure(feedItem: feedItem, user: user)
        footer.configure(feedItem: feedItem)
        if feedItem?.image != nil{
            imageView.sd_setImage(with: URL(string: (feedItem?.image)!), for: .normal, placeholderImage: UIImage(named: "hushPlaceholder"), options: SDWebImageOptions.init(rawValue: 0), completed: nil)
        }
        else{
            imageView.setImage(UIImage(named: "hushPlaceholder"), for: .normal)
        }
        textLabel.text = feedItem?.caption
    }
    
    //Button Delegates
    func profileButtonPressed(sender: UIButton){
        feedItemCellDelegate.relayDidPressProfileButton(sender: sender)
    }
    
    func nameButtonPressed(sender: UIButton){
        feedItemCellDelegate.relayDidPressNameButton(sender: sender)
    }
    
    func followButtonPressed(sender: UIButton){
        feedItemCellDelegate.relayDidPressFollowButton(sender: sender)
    }
    
    func moreButtonPressed(sender: UIButton){
        feedItemCellDelegate.relayDidPressMoreButton(sender: sender)
    }
    
    func imageViewSingleTapped() {
        feedItemCellDelegate.relayDidPressImageButton(sender: imageView, doubleTap: false)
    }
    
    func imageViewDoubleTapped() {
        feedItemCellDelegate.relayDidPressImageButton(sender: imageView, doubleTap: true)
    }
    
    func likeButtonPressed(sender: UIButton){
        feedItemCellDelegate.relayDidPressLikeButton(sender: sender)
    }
    
    func commentButtonPressed(sender: UIButton){
        feedItemCellDelegate.relayDidPressCommentButton(sender: sender)
    }
}
