//
//  AppDelegate.swift
//  Hush
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import Reachability
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Setup Firebase
        FirebaseApp.configure()
        
        // Set Initial View Controller
        self.setAppControllers(viewController: self.setupAppControllers())
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        //Stop listening for Reachability
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //Start listening for Reachability
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    func setupAppControllers() -> UIViewController{
        //Setup NavigationControllers for each tab
        let feedVC = FeedController()
        feedVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "feed"), selectedImage: UIImage(named: "feedFilled"))
        feedVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC1 = NavigationController.init(rootViewController: feedVC)
        
        let searchVC = SearchController()
        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search"), selectedImage: UIImage(named: "searchFilled"))
        searchVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC2 = NavigationController.init(rootViewController: searchVC)
        
        let browseVC = BrowseController()
        browseVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "browse"), selectedImage: UIImage(named: "browseFilled"))
        browseVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC3 = NavigationController.init(rootViewController: browseVC)
        
        let notificationsVC = NotificationsController()
        notificationsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "notifications"), selectedImage: UIImage(named: "notificationsFilled"))
        notificationsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC4 = NavigationController.init(rootViewController: notificationsVC)
        
        let accountVC = AccountController()
        accountVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "account"), selectedImage: UIImage(named: "accountFilled"))
        accountVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC5 = NavigationController.init(rootViewController: accountVC)
        
        //Setup TabBarController
        let tabVC = TabBarController()
        tabVC.viewControllers = [navVC1, navVC2, navVC3, navVC4, navVC5]
        tabVC.selectedIndex = 2
        
        return tabVC
    }
    
    func setAppControllers(viewController: UIViewController){
        //Set TabBarController as Window
        window?.rootViewController = viewController
    }
    
    //Reachability
    func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
            //Show notification that network is not reachable
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Hush")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

