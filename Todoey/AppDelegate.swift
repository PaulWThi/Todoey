//
//  AppDelegate.swift
//  Todoey
//
//  Created by paul thi on 2/4/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        // Uncomment to reveal Realm location filepath
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        do {
            _ = try Realm()
        } catch {
            print("error initializing new realm, \(error)")
        }
        
        
        
        return true
    }
    
}

