//
//  AppDelegate.swift
//  Todoey
//
//  Created by imedev4 on 02/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        

        do {
            _ = try Realm()

        } catch {
            print("(Error initialising new realm, \(error)")
        }

      
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }
}
