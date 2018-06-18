//
//  FeedSectionCell.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol FeedSectionCellDelegate {
    func didPressFeedSectionCell(indexPath: IndexPath)
    func didPressProfileButton(cell:UICollectionViewCell, indexPath: IndexPath?)
    func didPressNameButton(cell:UICollectionViewCell, indexPath: IndexPath?)
    func didPressFollowButton(sender: UIButton)
    func didPressMoreButton(sender: UIButton)
    func didPressImageButton(cell:UICollectionViewCell, doubleTap: Bool, indexPath: IndexPath?)
    func didPressLikeButton(sender: UIButton)
    func didPressCommentButton(cell:UICollectionViewCell, indexPath: IndexPath?)
    func didPullFeedSectionRefresh(cell: UICollectionViewCell)
}

class FeedSectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FeedItemCellDelegate{
    
    var feedSectionCellDelegate: FeedSectionCellDelegate!
    private var feedItems: [FeedItem]!
    private let communityCellIdentifier = "communityCell"
    private let feedCellIdentifier = "feedCell"
    private var refreshControl = UIRefreshControl()
    private var emptyCollectionViewLabel = UILabel()
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = HSColor.faintGray
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCollectionView(){
        //Register Cell for CollectionView
        collectionView.register(ShareWithCommunityCell.self, forCellWithReuseIdentifier: communityCellIdentifier)
        collectionView.register(FeedItemCell.self, forCellWithReuseIdentifier: feedCellIdentifier)
        self.addSubview(collectionView)
        
        //Setup RefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        //Setup EmptyCollectionView
        emptyCollectionViewLabel.text = "emptyFeed".localized()
        emptyCollectionViewLabel.textColor = .lightGray
        emptyCollectionViewLabel.textAlignment = .center
        emptyCollectionViewLabel.font  = UIFont.boldSystemFont(ofSize: 22)
        emptyCollectionViewLabel.numberOfLines = 0
    }
    
    func refreshData(){
        feedSectionCellDelegate.didPullFeedSectionRefresh(cell: self)
    }
    
    func configure(feedItems: [FeedItem]?){
        self.feedItems = feedItems
        self.refreshControl.endRefreshing()
        let indexSet = IndexSet(integer: 1)
        collectionView.reloadSections(indexSet)
    }
    
    func setupConstraints(){
        let viewDict = ["collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            if feedItems != nil{
                return feedItems.count
            }
            else{
                return 0
            }
        default:
            return 0
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch indexPath.section{
        case 0:
            return CGSize(width: collectionView.frame.width, height: 100)
        case 1:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width+120)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: communityCellIdentifier, for: indexPath) as! ShareWithCommunityCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellIdentifier, for: indexPath) as! FeedItemCell
            cell.feedItemCellDelegate = self
            let feedItem = feedItems[indexPath.item]
            let user = User()
            user.name = feedItem.userName
            user.image = feedItem.userImage
            user.rewardTier = feedItem.userRewardTier
            cell.configure(feedItem: feedItem, user: user)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: communityCellIdentifier, for: indexPath) as! ShareWithCommunityCell
            return cell
        }
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        feedSectionCellDelegate.didPressFeedSectionCell(indexPath: indexPath)
    }
    
    //FeedItemCell Delegate
    func relayDidPressProfileButton(sender: UIButton){
        feedSectionCellDelegate.didPressProfileButton(cell: self, indexPath: self.determineIndexPathForButton(sender: sender))
    }
    
    func relayDidPressNameButton(sender: UIButton){
        feedSectionCellDelegate.didPressNameButton(cell: self, indexPath: self.determineIndexPathForButton(sender: sender))
    }
    
    func relayDidPressFollowButton(sender: UIButton){
        feedSectionCellDelegate.didPressFollowButton(sender: sender)
    }
    
    func relayDidPressMoreButton(sender: UIButton){
        feedSectionCellDelegate.didPressMoreButton(sender: sender)
    }
    
    func relayDidPressImageButton(sender: UIButton, doubleTap: Bool){
        feedSectionCellDelegate.didPressImageButton(cell: self, doubleTap: doubleTap, indexPath: self.determineIndexPathForButton(sender: sender))
    }
    
    func relayDidPressLikeButton(sender: UIButton){
        feedSectionCellDelegate.didPressLikeButton(sender: sender)
    }
    
    func relayDidPressCommentButton(sender: UIButton){
        feedSectionCellDelegate.didPressCommentButton(cell: self, indexPath: self.determineIndexPathForButton(sender: sender))
    }
    
    func determineIndexPathForButton(sender: UIButton) -> IndexPath?{
        let touchPoint = sender.convert(CGPoint.zero, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: touchPoint)
        return indexPath
    }
    
}
