//
//  FeedController.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class FeedController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FeedSectionCellDelegate{
    
    private var segmentedControl = HMSegmentedControl()
    private var separatorLine = UIView()
    private let cellIdentifier = "cell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = HSColor.faintGray
        collectionView.showsVerticalScrollIndicator = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    private var isAtEndOfData = false
    private var isLoadingData = false
    private var feedItemManager = FeedItemManager()
    private var friendsFeedItems: [FeedItem]!
    private var trendingFeedItems: [FeedItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup View
        self.setupView()
        
        //Download Data
        self.downloadFriendsData(endValue: currentTimestamp(), refresh: false)
        self.downloadTrendingData(endValue: currentTimestamp(), refresh: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Prevent layout change when status bar is hidden
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Setup SegmentedControl
        self.setupSegmentedControl()
        
        //Setup Separator Line
        self.setupSeparatorLine()
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSegmentedControl(){
        segmentedControl = HMSegmentedControl(sectionTitles: feedSegmentedTitles)
        segmentedControl.frame = CGRect(x: 0, y: 20, width: w, height: 59.5)
        segmentedControl.tintColor = .lightGray
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectionIndicatorColor = HSColor.primary
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10)
        segmentedControl.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.lightGray]
        segmentedControl.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.darkGray]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
    }
    
    func setupSeparatorLine(){
        separatorLine.frame = .zero
        separatorLine.backgroundColor = UIColor.lightGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(separatorLine)
    }
    
    func setupCollectionView(){
        //Register Cell for CollectionView
        collectionView.register(FeedSectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)

        DispatchQueue.main.async {
            //Scroll to Initial Cell
            let initialIndexPath = IndexPath(item: 1, section: 0)
            self.collectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
            self.segmentedControl.setSelectedSegmentIndex(1, animated: false)
        }
    }
    
    func setupConstraints(){
        let viewDict = ["segmentedControl": segmentedControl, "separatorLine": separatorLine, "collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[segmentedControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[segmentedControl(59.5)][separatorLine(0.5)][collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadFriendsData(endValue: Double?, refresh: Bool){
        //Download Items
        feedItemManager.downloadFriendsFeedItems(endValue: endValue) { (feedItems) in
            self.friendsFeedItems = nil //Setting nil for demo purposes (following is not implemented)
            let indexPath = IndexPath(item: 0, section: 0)
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func downloadTrendingData(endValue: Double?, refresh: Bool){
        //Download Items
        feedItemManager.downloadTrendingFeedItems(endValue: endValue) { (feedItems) in
            self.trendingFeedItems = feedItems
            let indexPath = IndexPath(item: 1, section: 0)
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    //CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeedSectionCell
        cell.feedSectionCellDelegate = self
        switch indexPath.item{
        case 0:
            cell.configure(feedItems: friendsFeedItems)
            return cell
        case 1:
            cell.configure(feedItems: trendingFeedItems)
            return cell
        default:
            break
        }
        return cell
    }
    
    //CollectionViewCell Delegate
    func didPullFeedSectionRefresh(cell: UICollectionViewCell) {
        //Refresh section data when CollectionView UIRefreshControl is pulled
        let indexPath = self.collectionView.indexPath(for: cell)
        if indexPath?.item == 0{
            self.downloadFriendsData(endValue: currentTimestamp(), refresh: true)
        }
        else if indexPath?.item == 1{
            self.downloadTrendingData(endValue: currentTimestamp(), refresh: true)
        }
    }
    
    func didPressFeedSectionCell(indexPath: IndexPath){
        switch indexPath.item{
        case 0:
            //Login or Signup
            let welcomeVC = WelcomeController()
            let navVC = NavigationController(rootViewController: welcomeVC)
            self.present(navVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func didPressProfileButton(cell: UICollectionViewCell, indexPath: IndexPath?) {
        self.showProfileController(cell: cell, indexPath: indexPath)
    }
    
    func didPressNameButton(cell: UICollectionViewCell, indexPath: IndexPath?) {
        self.showProfileController(cell: cell, indexPath: indexPath)
    }
    
    func showProfileController(cell: UICollectionViewCell, indexPath: IndexPath?){
        var userId = String()
        if indexPath != nil{
            let sectionIndexPath = self.collectionView.indexPath(for: cell)
            if sectionIndexPath?.item == 0{
                let feedItem = friendsFeedItems[(indexPath?.item)!]
                userId = feedItem.userId
            }
            else if sectionIndexPath?.item == 1{
                let feedItem = trendingFeedItems[(indexPath?.item)!]
                userId = feedItem.userId
            }
        }
        let profileVC = ProfileController(userId: userId)
        profileVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func didPressFollowButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressMoreButton(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "report".localized(), style: .destructive, handler: { (alertAction) in
            //Report User
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: { (alertAction) in
            
        }))
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.width/2, y: sender.frame.height, width: CGFloat(1), height: CGFloat(1))
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        self.present(alert, animated: true, completion: nil)
    }
    
    func didPressImageButton(cell: UICollectionViewCell, doubleTap: Bool, indexPath: IndexPath?) {
        switch doubleTap{
        case true:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
        case false:
            self.showProfileController(cell: cell, indexPath: indexPath)
        }
    }

    func didPressLikeButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressCommentButton(cell: UICollectionViewCell, indexPath: IndexPath?) {
        self.showProfileController(cell: cell, indexPath: indexPath)
    }
    
    //Segmented Control Delegate
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        //Set CollectionView index to SegmentedControl index
        let indexPath = IndexPath(item: segmentedControl.selectedSegmentIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView == self.collectionView){
            //Change SegmentedControl index to match CollectionView index
            let pageWidth = scrollView.frame.size.width;
            let page = Int(scrollView.contentOffset.x / pageWidth);
            segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
        }
    }
}
