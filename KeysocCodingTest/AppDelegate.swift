//
//  AppDelegate.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        RealmTools.configRealm(schemaVersion: 2)
//        RealmHelper.configRealm()
        RealmTools.configRealm(schemaVersion: 1)
        return true
    }



}

