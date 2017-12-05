//
//  MainViewController.swift
//  お薬飲んだ？
//
//  Created by Kazumasa Nagao on 5/11/15.
//  Copyright (c) 2015 Kazumasa Nagao. All rights reserved.
//

import UIKit
import iAd

class MainViewController: UIViewController {
    
    @IBOutlet var morning: UIDatePicker!
    @IBOutlet var noon: UIDatePicker!
    @IBOutlet var night: UIDatePicker!
    @IBOutlet var morning_flag: UISwitch!
    @IBOutlet var noon_flag: UISwitch!
    @IBOutlet var night_flag: UISwitch!
    
    private var myWindow: UIWindow!
    private var myWindowButton: UIButton!
    @IBOutlet weak var myButton: UIButton!
    
    let alert = NSLocalizedString("Alert", comment:"")
    let close = NSLocalizedString("Close", comment:"")
    let script = NSLocalizedString("Script", comment:"")
    
    let userDefaults = NSUserDefaults(suiteName: "group.ryukyu.kaz")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let screen:CGSize = UIScreen.mainScreen().bounds.size
        if (screen.height == 480.0){
            morning.transform = CGAffineTransformMakeScale(1.0, 0.9);
            morning_flag.transform = CGAffineTransformMakeScale(1.0, 0.9);
            morning.transform = CGAffineTransformTranslate(morning.transform, 0, -20)
            morning_flag.transform = CGAffineTransformTranslate(morning_flag.transform, 0, -20)
            noon.transform = CGAffineTransformMakeScale(1.0, 0.9);
            noon_flag.transform = CGAffineTransformMakeScale(1.0, 0.9);
            noon.transform = CGAffineTransformTranslate(noon.transform, 0, -60)
            noon_flag.transform = CGAffineTransformTranslate(noon_flag.transform, 0, -60)
            night.transform = CGAffineTransformMakeScale(1.0, 0.9);
            night_flag.transform = CGAffineTransformMakeScale(1.0, 0.9);
            night.transform = CGAffineTransformTranslate(night.transform, 0, -100)
            night_flag.transform = CGAffineTransformTranslate(night_flag.transform, 0, -100)
        }
        
        self.canDisplayBannerAds = true
        
        myWindow = UIWindow()
        myWindowButton = UIButton()

        myWindow.tag = 0
        myWindowButton.tag = 1
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(
            UIUserNotificationSettings(
                forTypes:UIUserNotificationType.Sound | UIUserNotificationType.Alert,
                categories: nil)
        )
        
        morning.tag = 0
        morning.addTarget(self, action: "onDidChangeTime:", forControlEvents: .ValueChanged)
        noon.tag = 1
        noon.addTarget(self, action: "onDidChangeTime:", forControlEvents: .ValueChanged)
        night.tag = 2
        night.addTarget(self, action: "onDidChangeTime:", forControlEvents: .ValueChanged)
        
        let mor_fl = userDefaults?.boolForKey("morning_flag")
        morning_flag.on = mor_fl!
        morning_flag.tag = 0
        morning_flag.addTarget(self, action: "onDidChangeSwitch:", forControlEvents: .ValueChanged)
        let noo_fl = userDefaults?.boolForKey("noon_flag")
        noon_flag.on = noo_fl!
        noon_flag.tag = 1
        noon_flag.addTarget(self, action: "onDidChangeSwitch:", forControlEvents: .ValueChanged)
        let nig_fl = userDefaults?.boolForKey("night_flag")
        night_flag.on = nig_fl!
        night_flag.tag = 2
        night_flag.addTarget(self, action: "onDidChangeSwitch:", forControlEvents: .ValueChanged)
        
        morning.date = userDefaults?.objectForKey("morning_date") as! NSDate
        noon.date = userDefaults?.objectForKey("noon_date") as! NSDate
        night.date = userDefaults?.objectForKey("night_date") as! NSDate
        
        showNotificationFire()
        makeMyWindow()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func onDidChangeSwitch(sender: UISwitch){
        if (sender.tag == 0) {
            userDefaults?.setBool(morning_flag.on, forKey: "morning_flag")
        }
        if (sender.tag == 1) {
            userDefaults?.setBool(noon_flag.on, forKey: "noon_flag")
        }
        if (sender.tag == 2) {
            userDefaults?.setBool(night_flag.on, forKey: "night_flag")
        }
        showNotificationFire()
    }

    internal func onDidChangeTime(sender: UIDatePicker){
        var time = ""
        if (sender.tag == 0) {
            time = "morning_date"
        }
        if (sender.tag == 1) {
            time = "noon_date"
        }
        if (sender.tag == 2) {
            time = "night_date"
        }
        userDefaults?.setObject(sender.date, forKey: time)
        userDefaults?.synchronize()
        showNotificationFire()
    }
    
    private func showNotificationFire(){
        var times: Array<UIDatePicker> = []
        if (morning_flag.on == true) {
            times.append(morning)
        }
        if (noon_flag.on == true) {
            times.append(noon)
        }
        if (night_flag.on == true) {
            times.append(night)
        }
        UIApplication.sharedApplication().cancelAllLocalNotifications();
        if (times.count > 0) {
            for time in times {
                let myNotification: UILocalNotification = UILocalNotification()
                myNotification.repeatInterval = .CalendarUnitDay
                myNotification.alertBody = alert
                myNotification.soundName = UILocalNotificationDefaultSoundName
                myNotification.timeZone = NSTimeZone.localTimeZone()
                myNotification.fireDate = time.date
                UIApplication.sharedApplication().scheduleLocalNotification(myNotification)
            }
        }
    }
    
    internal func makeMyWindow(){
        
        myWindow.backgroundColor = UIColor.lightGrayColor()
        myWindow.frame = CGRectMake(0, 0, 250, 430)
        myWindow.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        myWindow.alpha = 1.0
        myWindow.layer.cornerRadius = 20
        myWindow.makeKeyWindow()
        self.myWindow.makeKeyAndVisible()
        
        myWindowButton.frame = CGRectMake(0, 0, 100, 40)
        myWindowButton.backgroundColor = UIColor.orangeColor()
        myWindowButton.setTitle(close, forState: .Normal)
        myWindowButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myWindowButton.layer.masksToBounds = true
        myWindowButton.layer.cornerRadius = 20.0
        myWindowButton.layer.position = CGPointMake(self.myWindow.frame.width/2, self.myWindow.frame.height-50)
        myWindowButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.myWindow.addSubview(myWindowButton)

        let myTextView: UITextView = UITextView(frame: CGRectMake(10, 10, self.myWindow.frame.width - 20, 330))
        myTextView.backgroundColor = UIColor.clearColor()
        myTextView.text = script
        myTextView.font = UIFont.systemFontOfSize(CGFloat(18))
        myTextView.textColor = UIColor.whiteColor()
        myTextView.textAlignment = NSTextAlignment.Left
        myTextView.editable = false
        
        myWindow.hidden = true
        self.myWindow.addSubview(myTextView)
    }

    internal func onClickMyButton(sender: UIButton) {
        
        if (sender.tag == 1) {
            myWindow.hidden = true
        }
        else if (sender.tag == 0) {
            myWindow.hidden = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
