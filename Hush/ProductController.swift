//
//  ProductController.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductController: UIViewController, ProductDropDownViewDelegate, UIScrollViewDelegate{
    
    private var product: Product!
    private var productScrollContainerView: ProductScrollContainerView!
    private var productDropDownView = ProductDropDownView()
    private var cartButton = CartButton()
    private var defaultBackgroundAlpha: CGFloat = 0.9
    private var isShowingDropDownView = false
    private var productDropDownTopConstraint = NSLayoutConstraint()
    
    init(product: Product?) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup View
        self.setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.init(white: 0, alpha: defaultBackgroundAlpha)
        
        //Setup Product Scroll ContainerView
        self.setupProductScrollContainerView()
        
        //Setup Product DropDown View
        self.setupProductDropDownView()
        
        //Setup Cart Button
        self.setupCartButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupProductScrollContainerView(){
        self.productScrollContainerView = ProductScrollContainerView(product: self.product)
        self.productScrollContainerView.scrollView.panGestureRecognizer.addTarget(self, action: #selector(self.handlePanGestureRecognizer(panGestureRecognizer:)))
        self.productScrollContainerView.scrollView.cancelButton.addTarget(self, action: #selector(self.cancelButtonPressed), for: .touchUpInside)
        self.productScrollContainerView.scrollView.likeButton.addTarget(self, action: #selector(self.likeButtonPressed), for: .touchUpInside)
        self.productScrollContainerView.scrollView.delegate = self
        self.productScrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(productScrollContainerView)
    }
    
    func setupProductDropDownView(){
        productDropDownView.productDropDownViewDelegate = self
        productDropDownView.configure(product: product)
        productDropDownView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(productDropDownView)
    }
    
    func setupCartButton(){
        cartButton.configure()
        cartButton.addTarget(self, action: #selector(self.cartButtonPressed), for: .touchUpInside)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cartButton)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productScrollContainerView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productScrollContainerView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productDropDownView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productDropDownView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.cartButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.cartButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productScrollContainerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productScrollContainerView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0))
        productDropDownTopConstraint = NSLayoutConstraint.init(item: self.productDropDownView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: -120)
        self.view.addConstraint(productDropDownTopConstraint)
        self.view.addConstraint(NSLayoutConstraint.init(item: self.productDropDownView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.cartButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.cartButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
    }
    
    //Button Delegates
    func cancelButtonPressed(sender: UIButton){
        self.dismissWithCustomAnimation()
    }
    
    func likeButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressBottomViewCancelButton(sender: UIButton) {
        self.dismissWithCustomAnimation()
    }
    
    func cartButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //ScrollView Delegate
    func handlePanGestureRecognizer(panGestureRecognizer: UIPanGestureRecognizer) {
        let yTranslation = panGestureRecognizer.translation(in: view).y
        
        //Handle Downward Scroll
        if productScrollContainerView.scrollView.contentOffset.y <= -100/2{
            self.productScrollContainerView.frame.origin.y = yTranslation-100
            //Change BackgroundColor
            let newAlpha = defaultBackgroundAlpha - (yTranslation-100)/self.view.frame.height
            self.view.backgroundColor = UIColor.init(white: 0, alpha: CGFloat(newAlpha))
        }
        else if productScrollContainerView.frame.origin.y > 0{
            self.productScrollContainerView.frame.origin.y = yTranslation-100
            //Change BackgroundColor
            let newAlpha = defaultBackgroundAlpha - (yTranslation-100)/self.view.frame.height
            self.view.backgroundColor = UIColor.init(white: 0, alpha: CGFloat(newAlpha))
        }
        else{
            self.view.backgroundColor = UIColor.init(white: 0, alpha: defaultBackgroundAlpha)
            self.productScrollContainerView.frame.origin.y = 0
        }
        
        if panGestureRecognizer.state == .ended{
            if self.productScrollContainerView.frame.origin.y > 0{
                self.dismissWithCustomAnimation()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == productScrollContainerView.scrollView{
            if productScrollContainerView.scrollView.contentOffset.y > 80{
                if !isShowingDropDownView{
                    UIView.animate(withDuration: 0.35, animations: {
                        self.productDropDownTopConstraint.constant = 0
                        self.isShowingDropDownView = true
                        self.view.layoutIfNeeded()
                    })
                }
            }
            if productScrollContainerView.scrollView.contentOffset.y <= 80{
                if isShowingDropDownView{
                    UIView.animate(withDuration: 0.35, animations: {
                        self.productDropDownTopConstraint.constant = -120
                        self.isShowingDropDownView = false
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    func dismissWithCustomAnimation(){
        if self.isShowingDropDownView{
            UIView.animate(withDuration: 0.35, animations: {
                self.productDropDownView.frame.origin.y = -self.productDropDownView.frame.height
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                self.dismissContainerViewWithAnimation()
            })
        }
        else{
            self.dismissContainerViewWithAnimation()
        }
    }
    
    func dismissContainerViewWithAnimation(){
        UIView.animate(withDuration: 0.35, animations: {
            self.cartButton.frame.origin.y = self.view.frame.height*2
            self.productScrollContainerView.frame.origin.y = self.view.frame.height*2
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
            self.view.layoutIfNeeded()
        }, completion: { (completed) in
            self.dismiss(animated: false, completion: nil)
        })
    }
}
