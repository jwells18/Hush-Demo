//
//  WelcomeController.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class WelcomeController: UIViewController{
    
    private var avPlayer = AVPlayer()
    private var avPlayerLayer = AVPlayerLayer()
    private var mainLogoView = UIImageView()
    private var mainLogoLabel = UILabel()
    private var facebookButton = FacebookSignupButton()
    private var signupButton = UIButton()
    private var separatorLine = UIView()
    private var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Show Navigation Bar
        self.navigationController?.isNavigationBarHidden = false
        
        //Add AVPlayer Observers
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackgroundNotification), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        self.avPlayer.isMuted = true
        self.avPlayer.play()
        
        //Set NavigationBar as translucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func setupNavigationBar(){
        //Setup Navigation Items
        if isModal(){
            let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel")!.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.cancelButtonPressed))
            cancelButton.tintColor = .white
            self.navigationItem.leftBarButtonItem = cancelButton
        }
        else{
            let backButton = UIBarButtonItem(image: UIImage(named: "back")!.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.backButtonPressed))
            backButton.tintColor = .white
            self.navigationItem.leftBarButtonItem = backButton
        }
        
    }
    
    //Setup View
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup AVPlayer
        self.setupAVPlayer()
        
        //Setup Main Logo ImageView
        self.setupMainLogoView()
        
        //Setup Main Logo Label
        self.setupMainLogoLabel()
        
        //Setup Facebook Button
        self.setupFacebookButton()
        
        //Setup Signup Button
        self.setupSignupButton()
        
        //Setup Separator Line
        self.setupSeparatorLine()
        
        //Setup Login Button
        self.setupLoginButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupAVPlayer(){
        //Setup AVPlayer
        guard let path = Bundle.main.path(forResource: "welcomeVideo", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        //Prevent background music from being stopped
        _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
        self.view.layer.addSublayer(avPlayerLayer)
    }
    
    func setupMainLogoView(){
        mainLogoView.image = UIImage(named: "hushLogoWhite")
        mainLogoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainLogoView)
    }
    
    func setupMainLogoLabel(){
        mainLogoLabel.text = "welcomeMainLabel".localized().uppercased()
        mainLogoLabel.textColor = .white
        mainLogoLabel.textAlignment = .center
        mainLogoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        mainLogoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainLogoLabel)
    }
    
    func setupFacebookButton(){
        facebookButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(facebookButton)
    }
    
    func setupSignupButton(){
        signupButton.setTitle("claimWithEmail".localized().uppercased(), for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        signupButton.titleLabel?.numberOfLines = 2
        signupButton.titleLabel?.textAlignment = .center
        signupButton.addTarget(self, action: #selector(self.signupButtonPressed), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signupButton)
    }
    
    func setupSeparatorLine(){
        self.separatorLine.backgroundColor = .white
        self.separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.separatorLine)
    }
    
    func setupLoginButton(){
        loginButton.setTitle("alreadyAMember".localized().uppercased(), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.titleLabel?.numberOfLines = 2
        loginButton.titleLabel?.textAlignment = .center
        loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: mainLogoView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.4, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: mainLogoView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: mainLogoLabel, attribute: .centerX, relatedBy: .equal, toItem: self.mainLogoView, attribute: .centerX, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: facebookButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.9, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: facebookButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: signupButton, attribute: .width, relatedBy: .equal, toItem: facebookButton, attribute: .width, multiplier: 0.5, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: signupButton, attribute: .left, relatedBy: .equal, toItem: facebookButton, attribute: .left, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: separatorLine, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0.5)])
        self.view.addConstraints([NSLayoutConstraint.init(item: separatorLine, attribute: .left, relatedBy: .equal, toItem: signupButton, attribute: .right, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: loginButton, attribute: .width, relatedBy: .equal, toItem: facebookButton, attribute: .width, multiplier: 0.5, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: loginButton, attribute: .right, relatedBy: .equal, toItem: facebookButton, attribute: .right, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: mainLogoView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 80)])
        self.view.addConstraints([NSLayoutConstraint.init(item: mainLogoView, attribute: .height, relatedBy: .equal, toItem: mainLogoView, attribute: .width, multiplier: 0.317, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: mainLogoLabel, attribute: .top, relatedBy: .equal, toItem: mainLogoView, attribute: .bottom, multiplier: 1, constant: 16)])
        self.view.addConstraints([NSLayoutConstraint.init(item: facebookButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -100)])
        self.view.addConstraints([NSLayoutConstraint.init(item: facebookButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.view.addConstraints([NSLayoutConstraint.init(item: signupButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.view.addConstraints([NSLayoutConstraint.init(item: signupButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -20)])
        self.view.addConstraints([NSLayoutConstraint.init(item: separatorLine, attribute: .height, relatedBy: .equal, toItem: signupButton, attribute: .height, multiplier: 0.5, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: separatorLine, attribute: .centerY, relatedBy: .equal, toItem: signupButton, attribute: .centerY, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.view.addConstraints([NSLayoutConstraint.init(item: loginButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -20)])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avPlayerLayer.frame = self.view.frame
    }
    
    //AVPlayer Delegate
    func playerItemDidReachEnd(notification: NSNotification){
        let item = notification.object as! AVPlayerItem
        item.seek(to: kCMTimeZero)
        self.avPlayer.play()
    }
    
    func appWillEnterForegroundNotification() {
        self.avPlayer.play()
    }
    
    func appDidEnterBackgroundNotification() {
        self.avPlayer.pause()
    }
    
    //Button Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func facebookButtonPressed(){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func signupButtonPressed(){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func loginButtonPressed(){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Other Functions
    func isModal() -> Bool {
        if self.presentingViewController != nil{
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController{
            return true
        }
        return false
    }
}
