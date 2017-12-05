//
//  InterfaceController.swift
//  お薬飲んだ？ WatchKit Extension
//
//  Created by Kazumasa Nagao on 5/14/15.
//  Copyright (c) 2015 Kazumasa Nagao. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var appTitle: WKInterfaceLabel!
    @IBOutlet weak var setting: WKInterfaceLabel!
    @IBOutlet weak var morning_label: WKInterfaceLabel!
    @IBOutlet weak var noon_label: WKInterfaceLabel!
    @IBOutlet weak var night_label: WKInterfaceLabel!
    let userDefaults = NSUserDefaults(suiteName: "group.ryukyu.kaz")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let AppTitle = NSLocalizedString("AppTitle", comment:"")
        let Setting = NSLocalizedString("Setting", comment:"")
        appTitle.setText(AppTitle)
        setting.setText(Setting)
        
        var morning_flag  = userDefaults?.boolForKey("morning_flag")
        if (morning_flag == true) {
            var morning = userDefaults?.objectForKey("morning_date") as! NSDate
            let myDateFormatter: NSDateFormatter = NSDateFormatter()
            myDateFormatter.dateFormat = "hh-mm"
            let mySelectedTime: NSString = myDateFormatter.stringFromDate(morning)
            morning_label.setText(mySelectedTime as String)
        } else {
            morning_label.setText("")
        }
        var noon_flag  = userDefaults?.boolForKey("noon_flag")
        if (noon_flag == true) {
            var noon = userDefaults?.objectForKey("noon_date") as! NSDate
            let myDateFormatter: NSDateFormatter = NSDateFormatter()
            myDateFormatter.dateFormat = "hh-mm"
            let mySelectedTime: NSString = myDateFormatter.stringFromDate(noon)
            noon_label.setText(mySelectedTime as String)
        } else {
            noon_label.setText("")
        }
        var night_flag = userDefaults?.boolForKey("night_flag")
        if (night_flag == true) {
            var night = userDefaults?.objectForKey("night_date") as! NSDate
            let myDateFormatter: NSDateFormatter = NSDateFormatter()
            myDateFormatter.dateFormat = "hh-mm"
            let mySelectedTime: NSString = myDateFormatter.stringFromDate(night)
            night_label.setText(mySelectedTime as String)
        } else {
            night_label.setText("")
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
