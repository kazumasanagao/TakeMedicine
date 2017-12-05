//
//  AppDelegate.swift
//  お薬飲んだ？
//
//  Created by Kazumasa Nagao on 5/11/15.
//  Copyright (c) 2015 Kazumasa Nagao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userDefaults = NSUserDefaults(suiteName: "group.ryukyu.kaz")

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        if (userDefaults?.integerForKey("default") == 0) {
            userDefaults?.setObject(timeSerial(2000, month:1, day: 1,hour: 7, minute: 30, second: 00), forKey: "morning_date")
            userDefaults?.setObject(timeSerial(2000, month:1, day: 1,hour: 12, minute: 30, second: 00), forKey: "noon_date")
            userDefaults?.setObject(timeSerial(2000, month:1, day: 1,hour: 19, minute: 30, second: 00), forKey: "night_date")
            userDefaults?.setBool(true, forKey: "morning_flag")
            userDefaults?.setBool(true, forKey: "noon_flag")
            userDefaults?.setBool(true, forKey: "night_flag")
            userDefaults?.setInteger(1, forKey: "default")

            userDefaults?.synchronize()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func timeSerial(year:Int, month:Int, day:Int, hour:Int, minute: Int, second: Int) -> NSDate {
        var comp = NSDateComponents()
        comp.year = year
        comp.month = month
        comp.day = day
        comp.hour = hour
        comp.minute = minute
        comp.second = second
        var cal = NSCalendar.currentCalendar()
        var time = cal.dateFromComponents(comp)
        return time!
    }


}

