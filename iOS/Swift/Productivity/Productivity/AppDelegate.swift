
//
//  AppDelegate.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 21.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftDate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Requesting authorization
        let center =  UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
            //handle result of request failure
        }
        center.delegate = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        let region = Region.local
        let date = DateInRegion(Date(), region: region)
      
        // Print check
        print(region)
        print(date.compare(.isToday))
        print(date.weekday)
        print(date.minute)
        print(date.weekdayName(.short))
        
        print((date + 1.weeks).weekday)
        
        for i in 1...7 {
            print((date + i.days).weekday)
            //print((date + i.days).weekOfYear)
            setDailyNotifications(forDate: (date + i.days))

        }
    }
    
    func setDailyNotifications(forDate date: DateInRegion) {
        
        let defaults = UserDefaults.standard
        let allTasks = defaults.object(forKey: "tasks") as! [[String : Any]]
        var countTasks = 0
        
        for task in allTasks {
            let weekDays = task["weekDays"] as![String : Int]
            
            if(weekDays["\(date.weekday)"] == 1) {
                countTasks += 1
            }
        }
        
        let notification = UNMutableNotificationContent()
        notification.body = "You have \(countTasks) tasks today!"
//        notification.title = " Jurassic Park"
//        notification.subtitle = "Lunch"
        //content.sound = UNNotificationSound.default()
        notification.badge = 1
        
        
        // Notification with the goal count every day at 08:00
        var dateComponents = DateComponents()
        dateComponents.weekday = date.weekday
        dateComponents.hour = 8
        dateComponents.minute = 0
        var notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        var request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // If not opened by then
        // Notification with the goal count every day at 13:00
        dateComponents.hour = 13
        //dateComponents.minute = 0
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        request = UNNotificationRequest(identifier: "notification2", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // If not opened by then
        // Notification with the goal count every day at 18:00
        dateComponents.hour = 18
        //dateComponents.minute = 0
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        request = UNNotificationRequest(identifier: "notification3", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    /*
        // Fix hour
        dateComponents.hour = date.hour
        dateComponents.minute = date.minute
        dateComponents.second = date.second
        
        if(dateComponents.second! >= 50) {
            dateComponents.second = (date.second + 10) % 60
            dateComponents.minute = date.minute + 1
            if(dateComponents.minute == 60) {
                dateComponents.hour = date.hour + 1
            }
        } else {
            dateComponents.second = date.second + 10
        }
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        print(dateComponents)
        request = UNNotificationRequest(identifier: "notification2", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
         */
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
 

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // response
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    // notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
    }
    /*
    func notification() {
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = " Jurassic Park"
        content.subtitle = "Lunch"
        content.body = "Its lunch time at the park, please join us for a dinosaur feeding"
        content.sound = UNNotificationSound.default()
        content.badge = 1
        
        // add notification for Mondays at 11:00 a.m.
        var dateComponents = DateComponents()
        dateComponents.weekday = 2
        dateComponents.hour = 11
        dateComponents.minute = 0
        
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5.0, repeats: false)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    */
}

