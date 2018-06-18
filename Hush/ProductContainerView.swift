//
//  ProductContainerView.swift
//  Hush
//
//  Created by Justin Wells on 6/11/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductContainerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellIdentifier = "cell"
    var productHeaderView: ProductHeaderView!
    var productDetailsView: ProductDetailsView!
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        layout.scrollDirection = .horizontal
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        
        return collectionView
    }()
    var product: Product!
    
    convenience init(product: Product) {
        self.init()
        self.product = product
        //Setup View
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        //Setup ProductHeaderView
        self.setupProductHeaderView()
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup ProductDetailsView
        self.setupProductDetailsView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupProductHeaderView(){
        productHeaderView = ProductHeaderView(product: product)
        productHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(productHeaderView)
    }
    
    func setupCollectionView(){
        //Register Cell for CollectionView
        collectionView.register(ProductImageCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
    }
    
    func setupProductDetailsView(){
        productDetailsView = ProductDetailsView(product: product)
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(productDetailsView)
    }
    
    func setupConstraints(){
        let viewDict = ["productHeaderView": productHeaderView, "collectionView": collectionView, "productDetailsView": productDetailsView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: productHeaderView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: productHeaderView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: collectionView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: productDetailsView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: productDetailsView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[productHeaderView]-16-[collectionView]-16-[productDetailsView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: collectionView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.1, constant: 32))
    }
    
    //CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (collectionView.frame.width*0.7)-32, height: (collectionView.frame.width*1.1)-32)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductImageCell
        cell.configure(product: product)
        return cell
    }
}
