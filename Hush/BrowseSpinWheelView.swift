//
//  BrowseSpinWheelView.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import LinearProgressBar

class BrowseSpinWheelView: UIView{
    
    var spinnerRod = LinearProgressBar()
    var spinnerWheel = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.clipsToBounds = true
        
        //Setup Spinner Rod
        self.setupSpinnerRod()
        
        //Setup Spinner Wheel
        self.setupSpinnerWheel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSpinnerRod(){
        self.spinnerRod.backgroundColor = .clear
        self.spinnerRod.barColor = HSColor.tertiaryDark
        self.spinnerRod.trackColor = HSColor.tertiary
        self.spinnerRod.trackPadding = 0
        self.spinnerRod.translatesAutoresizingMaskIntoConstraints = false
        self.spinnerRod.progressValue = 0
        self.addSubview(spinnerRod)
    }
    
    func setupSpinnerWheel(){
        self.spinnerWheel.backgroundColor = HSColor.tertiary
        self.spinnerWheel.image = UIImage(named: "wheel")
        self.spinnerWheel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.spinnerWheel.clipsToBounds = true
        self.spinnerWheel.layer.cornerRadius = 30/2
        self.addSubview(spinnerWheel)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: spinnerRod, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spinnerRod, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: spinnerRod, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10))
        self.addConstraint(NSLayoutConstraint.init(item: spinnerRod, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    //Animations
    func startWheelAnimation(){
        let duration = 2.0
        UIView.animate(withDuration: duration) {
            self.spinnerWheel.frame = CGRect(x: self.frame.width-30, y: 0, width: 30, height: 30)
            self.rotateAnimation(view: self.spinnerWheel, duration: duration/2)
        }
    }
    
    func rotateAnimation(view: UIView, duration: CFTimeInterval) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = 2
        view.layer.add(rotateAnimation, forKey: nil)
    }
    
    func resetWheelAnimation(){
        self.spinnerWheel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.spinnerWheel.layer.removeAllAnimations()
    }
}
