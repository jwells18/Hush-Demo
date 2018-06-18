//
//  BrowseSectionCell.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol BrowseSectionCellDelegate {
    func didPressProductCell(cell: UICollectionViewCell, indexPath: IndexPath)
    func didPressLikeButton(sender: UIButton)
    func didPressAddToCartButton(sender: UIButton)
    func didScrollBrowseSectionCell(offset: CGPoint)
}

class BrowseSectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ProductCellDelegate, UIScrollViewDelegate{
    
    var browseSectionCellDelegate: BrowseSectionCellDelegate!
    var products: [Product]!
    private let productCellIdentifier = "productCell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        
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
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: productCellIdentifier)
        self.addSubview(collectionView)
    }
    
    func setupConstraints(){
        let viewDict = ["collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(products: [Product]?){
        self.products = products
        self.collectionView.reloadData()
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if products != nil{
            return products.count
        }
        else{
            return 0
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellWidth = (collectionView.frame.width-36)/2
        return CGSize(width: cellWidth, height: cellWidth*1.2+190/*400*/)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier, for: indexPath) as! ProductCell
        cell.productCellDelegate = self
        cell.configure(product: products[indexPath.item])
        return cell
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.browseSectionCellDelegate.didPressProductCell(cell: self, indexPath: indexPath)
    }
    
    //ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == self.collectionView){
            self.browseSectionCellDelegate.didScrollBrowseSectionCell(offset: scrollView.contentOffset)
        }
    }
    
    //Product Cell Delegate
    func relayDidPressLikeButton(sender: UIButton){
        self.browseSectionCellDelegate.didPressLikeButton(sender: sender)
    }
    
    func relayDidPressAddToCartButton(sender: UIButton){
        self.browseSectionCellDelegate.didPressAddToCartButton(sender: sender)
    }
}
