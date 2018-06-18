//
//  ProfileController.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProfileController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FeedItemCellDelegate, ProfileCellDelegate {
    
    private let profileCellIdentifier = "profileCell"
    private let feedCellIdentifier = "feedCell"
    private var userId: String!
    private var user: User!
    private var feedItems: [FeedItem]!
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = HSColor.faintGray
        collectionView.alwaysBounceVertical = true

        return collectionView
    }()
    
    init(userId: String?) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
        
        //DownloadData()
        self.downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Show Navigation Bar
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = nil
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "more2"), style: .plain, target: self, action: #selector(self.moreButtonPressed))
        self.navigationItem.rightBarButtonItem = moreButton
    }
    
    func setupView(){
        self.view.backgroundColor = HSColor.faintGray
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCollectionView(){
        //Register Cell for CollectionView
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellIdentifier)
        collectionView.register(FeedItemCell.self, forCellWithReuseIdentifier: feedCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
    }
    
    func downloadData(){
        //Download User
        let userManager = UserManager()
        userManager.downloadUser(uid: userId) { (user) in
            self.user = user

            if user != nil{
                //Download Feed Items
                let feedItemManager = FeedItemManager()
                feedItemManager.downloadFeedItems(uid: user?.objectId) { (feedItems) in
                    self.feedItems = feedItems
                    self.navigationItem.title = self.user.name
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func setupConstraints(){
        let viewDict = ["collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if feedItems != nil{
            return feedItems.count+1
        }
        else{
            return 1
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch indexPath.item{
        case 0:
            return CGSize(width: collectionView.frame.width, height: 470)
        default:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width+120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as! ProfileCell
            cell.profileCellDelegate = self
            cell.configure(user: user)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellIdentifier, for: indexPath) as! FeedItemCell
            cell.feedItemCellDelegate = self
            cell.header.followButton.isHidden = true
            cell.configure(feedItem: feedItems[indexPath.item-1], user: user)
            return cell
        }
    }
    
    //CollectionViewCell Delegate
    func relayDidPressProfileButton(sender: UIButton){
        self.showProfileController()
    }
    
    func relayDidPressNameButton(sender: UIButton){
        self.showProfileController()
    }
    
    func relayDidPressFollowButton(sender: UIButton){
        //Nothing. Follow Button is Hidden
    }
    
    func relayDidPressMoreButton(sender: UIButton){
        self.showMoreOptions(sender: sender)
    }
    
    func relayDidPressImageButton(sender: UIButton, doubleTap: Bool){
        //Nothing. Profile page is already displayed
    }
    
    func relayDidPressLikeButton(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func relayDidPressCommentButton(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func showProfileController(){
        let profileVC = ProfileController(userId: self.user.objectId)
        profileVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func didPressRewardTierButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFollowButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressLikesButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFollowersButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFollowingButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Button Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func moreButtonPressed(sender: UIButton) {
        self.showMoreOptions(sender: sender)
    }
    
    //Other Functions
    func showMoreOptions(sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "report".localized(), style: .destructive, handler: { (alertAction) in
            //Report User
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: { (alertAction) in
            
        }))
        alert.popoverPresentationController?.sourceView = sender
        if(sender.isKind(of: UIBarButtonItem.self)){
            alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        }
        else{
            alert.popoverPresentationController?.sourceRect = CGRect(x: sender.frame.width/2, y: sender.frame.height, width: CGFloat(1), height: CGFloat(1))
        }
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        self.present(alert, animated: true, completion: nil)
    }
}
