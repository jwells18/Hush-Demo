//
//  BrowseController.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class BrowseController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BrowseSectionCellDelegate{
    
    var browseSectionsDict = Dictionary<String, [Product]>()
    private var browseHeader = BrowseHeader()
    private var isBrowseHeaderExpanded = false
    private var browseHeaderHeightConstraint = NSLayoutConstraint()
    private var segmentedControlInitialIndex = 13
    private var segmentedControl = HMSegmentedControl()
    private var separatorLine = UIView()
    private let cellIdentifier = "cell"
    private var downloadingActivityView = UIActivityIndicatorView()
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
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    private var isInitialDownloadDict = Dictionary<String, Bool>()
    private var isAtEndOfDataDict = Dictionary<String, Bool>()
    private var isLoadingDataDict = Dictionary<String, Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Initial Values
        for sectionTitle in browseSegmentedTitles{
            isInitialDownloadDict[sectionTitle] = true
            isAtEndOfDataDict[sectionTitle] = false
            isLoadingDataDict[sectionTitle] = false
        }
        
        //Download Data
        self.downloadData(index: segmentedControlInitialIndex)
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Prevent layout change when status bar is hidden
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Setup SegmentedControl
        self.setupSegmentedControl()
        
        //Setup Separator Line
        self.setupSeparatorLine()
        
        //Setup Browse Header
        self.setupBrowseHeader()
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSegmentedControl(){
        segmentedControl = HMSegmentedControl(sectionTitles: browseSegmentedTitles)
        segmentedControl.frame = CGRect(x: 0, y: 20, width: w, height: 60)
        segmentedControl.tintColor = .lightGray
        segmentedControl.selectedSegmentIndex = segmentedControlInitialIndex
        segmentedControl.selectionIndicatorColor = HSColor.primary
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorHeight = 4
        segmentedControl.segmentWidthStyle = .dynamic
        segmentedControl.selectionStyle = .textWidthStripe
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 16, 0, 16)
        segmentedControl.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.lightGray]
        segmentedControl.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.darkGray]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
    }
    
    func setupSeparatorLine(){
        separatorLine.frame = .zero
        separatorLine.backgroundColor = HSColor.faintGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(separatorLine)
    }
    
    func setupBrowseHeader(){
        browseHeader.seePrizesButton.addTarget(self, action: #selector(self.seePrizesButtonPressed), for: .touchUpInside)
        browseHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(browseHeader)
        
        DispatchQueue.main.async {
            self.browseHeader.spinWheelView.startWheelAnimation()
        }
    }
    
    func setupCollectionView(){
        collectionView.register(BrowseSectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        //Setup Downloading ActivityView
        //TODO: Adjust activityIndicatorView to be visible in the hierarchy (needs to be added to cell's collectionView)
        downloadingActivityView.activityIndicatorViewStyle = .gray
        collectionView.backgroundView = downloadingActivityView
        
        DispatchQueue.main.async {
            //Scroll to Initial Cell
            let initialIndexPath = IndexPath(item: self.segmentedControlInitialIndex, section: 0)
            self.collectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
            self.segmentedControl.setSelectedSegmentIndex(UInt(self.segmentedControlInitialIndex), animated: false)
        }
    }
    
    func setupConstraints(){
        let viewDict = ["segmentedControl": segmentedControl, "separatorLine": separatorLine, "browseHeader": browseHeader, "collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[segmentedControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[browseHeader]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraint(NSLayoutConstraint.init(item: segmentedControl, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 20))
        self.view.addConstraint(NSLayoutConstraint.init(item: segmentedControl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 36))
        self.view.addConstraint(NSLayoutConstraint.init(item: separatorLine, attribute: .bottom, relatedBy: .equal, toItem: browseHeader, attribute: .top, multiplier: 1, constant: -0.5))
        self.view.addConstraint(NSLayoutConstraint.init(item: separatorLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0.5))
        self.view.addConstraint(NSLayoutConstraint.init(item: browseHeader, attribute: .top, relatedBy: .equal, toItem: segmentedControl, attribute: .bottom, multiplier: 1, constant: 10))
        browseHeaderHeightConstraint = NSLayoutConstraint.init(item: browseHeader, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        self.view.addConstraint(browseHeaderHeightConstraint)
        self.view.addConstraint(NSLayoutConstraint.init(item: collectionView, attribute: .top, relatedBy: .equal, toItem: browseHeader, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        separatorLine.frame = CGRect(x: 0, y: segmentedControl.frame.height+10, width: segmentedControl.frame.width, height: 0.5)
    }
    
    func downloadData(index: Int){
        let productManager = ProductManager()
        let browseSectionTitle = browseSegmentedTitles[index]
        
        //Start Downloading ActivityView
        if self.isInitialDownloadDict[browseSectionTitle] == true{
            downloadingActivityView.startAnimating()
        }
        
        if(isAtEndOfDataDict[browseSectionTitle] == false && isLoadingDataDict[browseSectionTitle] == false){
            isLoadingDataDict[browseSectionTitle] = true
            productManager.downloadProducts(endValue: currentTimestamp()) { (products) in
                //Stop Downloading ActivityView
                if(self.downloadingActivityView.isAnimating){
                    self.downloadingActivityView.stopAnimating()
                }
                
                self.isLoadingDataDict[browseSectionTitle] = false
                self.isInitialDownloadDict[browseSectionTitle] = false
                
                //Update Products Array
                var currentProducts = self.browseSectionsDict[browseSectionTitle]
                if(currentProducts != nil){
                    currentProducts?.append(contentsOf: products)
                }
                else{
                    currentProducts = products
                }
                self.browseSectionsDict[browseSectionTitle] = currentProducts
                
                let indexPath = IndexPath(item: index, section: 0)
                self.collectionView.reloadItems(at: [indexPath])
                
                //Check if At the End of Data
                if(products.count == 0){
                    self.isAtEndOfDataDict[browseSectionTitle] = true
                }
                else{
                    self.isAtEndOfDataDict[browseSectionTitle] = false
                }
            }
        }
        else{
            isLoadingDataDict[browseSectionTitle] = false
        }
    }
    
    //CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return browseSegmentedTitles.count
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BrowseSectionCell
        cell.browseSectionCellDelegate = self
        let browseSectionTitle = browseSegmentedTitles[indexPath.item]
        let products = browseSectionsDict[browseSectionTitle]
        cell.configure(products: products)
        return cell
    }
    
    //CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let browseSectionTitle = browseSegmentedTitles[indexPath.item]
        if(self.browseSectionsDict[browseSectionTitle] == nil && isInitialDownloadDict[browseSectionTitle] == true){
            downloadData(index: indexPath.item)
        }
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
            let page = Int(scrollView.contentOffset.x / pageWidth)
            segmentedControl.setSelectedSegmentIndex(UInt(page), animated: true)
        }
    }
    
    func didScrollBrowseSectionCell(offset: CGPoint){
        if offset.y > -100{
            //Increase header height
            browseHeaderHeightConstraint.constant = 200
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.view.layoutIfNeeded()

            //Start Wheel Animation
            self.browseHeader.spinWheelView.startWheelAnimation()
            
            isBrowseHeaderExpanded = true
        }
        if(offset.y > 0){
            if isBrowseHeaderExpanded{
                browseHeaderHeightConstraint.constant = 40
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.view.layoutIfNeeded()
                
                //Reset Wheel Animation
                self.browseHeader.spinWheelView.resetWheelAnimation()
                
                isBrowseHeaderExpanded = false
            }
        }
    }
    
    //Browse Section Cell
    func didPressProductCell(cell: UICollectionViewCell, indexPath: IndexPath){
        let sectionCellIndexPath = self.collectionView.indexPath(for: cell)
        //TODO: Add error handling for sectionCellIndexPath
        let browseSectionTitle = browseSegmentedTitles[(sectionCellIndexPath?.item)!]
        let products = browseSectionsDict[browseSectionTitle]
        
        let productVC = ProductController(product: products?[indexPath.item])
        productVC.modalPresentationStyle = .overFullScreen
        productVC.modalPresentationCapturesStatusBarAppearance = true
        self.present(productVC, animated: false, completion: nil)
    }
    
    func didPressLikeButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressAddToCartButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Browse Header Delegate
    func seePrizesButtonPressed(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}
