//
//  ProductImageCell.swift
//  Hush
//
//  Created by Justin Wells on 6/11/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

class ProductImageCell: UICollectionViewCell{
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup ImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = HSColor.faintGray
        imageView.layer.cornerRadius = 10
        self.addSubview(imageView)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(product: Product?){
        switch product?.image != nil {
        case true:
            self.imageView.sd_setImage(with: URL(string: (product?.image)!), placeholderImage: UIImage(named: "hushPlaceholder"), options: SDWebImageOptions.init(rawValue: 0), completed: nil)
        case false:
            self.imageView.image = UIImage(named: "sampleProductImage1")
        }
    }
}
