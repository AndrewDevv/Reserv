//
//  AppDelegate.swift
//  Reservation
//
//  Created by Андрей Антонов on 22.07.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        
        let initialViewController = AuthorizationViewController()
        navigationController.viewControllers = [initialViewController]
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = UIColor(displayP3Red: 25/255, green: 191/255, blue: 111/255, alpha: 1)
        FirebaseApp.configure()
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reservation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

