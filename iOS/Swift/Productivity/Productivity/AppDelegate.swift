
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
        //setNotificationsForToday()
        setCategories()
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
//        print(region)
//        print(date.compare(.isToday))
//        print(date.weekday)
//        print(date.minute)
//        print(date.weekdayName(.short))
        
        //print((date + 1.weeks).weekday)
        setNotificationsForToday()
        
        for i in 1...6 {
           print((date + i.days))
            //print((date + i.days).weekOfYear)
            setWeeklyNotifications(forDate: (date + i.days))

        }
    }
    
    func setWeeklyNotifications(forDate date: DateInRegion) {
        
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
        var notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        var request = UNNotificationRequest(identifier: "morningnotification \(date.weekday)", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // If not opened by then
        // Notification with the goal count every day at 13:00
        dateComponents.hour = 13
        //dateComponents.minute = 0
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        request = UNNotificationRequest(identifier: "afternoonnotification \(date.weekday)", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // If not opened by then
        // Notification with the goal count every day at 18:00
        dateComponents.hour = 18
        //dateComponents.minute = 0
        notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        request = UNNotificationRequest(identifier: "eveningnotification \(date.weekday)", content: notification, trigger: notificationTrigger)
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
        //setNotificationsForToday()
    }
    
    func setNotificationsForToday() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let region = Region.local
        let date = DateInRegion(Date(), region: region)
        let defaults = UserDefaults.standard
        let allTasks = defaults.object(forKey: "tasks") as! [[String : Any]]
       
        let endHour = 21
        
        for task in allTasks  {
            let timesADay = task["timesADay"] as! Int
            let timesCompleted = task["timesCompleted"] as! Int
            let title = task["title"] as! String
            let timesLeft = timesADay - timesCompleted
            
            if(timesLeft > 0) {
                let interval : Float = Float(endHour - date.hour) / Float(timesLeft)
                print("\(interval)")
                let intervalHours = Int(interval)
                let intervalMinutes = Int((interval - Float(intervalHours)) * 60)
                print("\(intervalHours) : \(intervalMinutes)")
                
                for i in 1...timesLeft {
                    
                    let notification = UNMutableNotificationContent()
                    notification.body = "\(title) \(timesCompleted) / \(timesADay)"
                    notification.badge = 1
                    notification.categoryIdentifier = "task.category"
                    
                    
                    // Notification with the goal count every day at 08:00
                    var dateComponents = DateComponents()
                    dateComponents.weekday = date.weekday
//                    dateComponents.weekOfYear = date.weekOfYear
//                    dateComponents.year = date.year
                    dateComponents.hour = date.hour + (i * intervalHours)
                    
                    if(date.minute + (i * intervalMinutes) > 60) {
                        let temp = Float(date.minute + (i * intervalMinutes)) / 60.0
                        let addHours = Int(temp)
                        dateComponents.minute = Int((temp - Float(addHours)) * 60)
                        dateComponents.hour = dateComponents.hour! + addHours
                        
                    }   else {
                        dateComponents.minute = date.minute + (i * intervalMinutes)
                    }
                    
                    print(title + " \(dateComponents.hour!):\(dateComponents.minute!)")
                    
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let request = UNNotificationRequest(identifier: "notification\(i)", content: notification, trigger: notificationTrigger)
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    
                }
                
//                var notification = UNMutableNotificationContent()
//                notification.body = "\(title) \(timesCompleted) / \(timesADay)"
//                notification.badge = 1
//                notification.categoryIdentifier = "task.category"
//
//                var dateComponents = DateComponents()
//                dateComponents.weekday = date.weekday
//                dateComponents.hour = date.hour
//                dateComponents.minute = date.minute + 1
//                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//                var request = UNNotificationRequest(identifier: "not1", content: notification, trigger: notificationTrigger)
//                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
//                notification.body = "Test"
//                request = UNNotificationRequest(identifier: "not2", content: notification, trigger: notificationTrigger)
//                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)


            }
        }
    
    }
 

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        setNotificationsForToday()
        setWeeklyNotifications(forDate: DateInRegion(Date(), region: Region.local))
    }

    // response
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
     
        // Add IDs
        let identifier = response.actionIdentifier
        let request = response.notification.request
        if identifier == "complete"{
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = request.content.body
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0 * 60, repeats: false)
            
           
            let newRequest = UNNotificationRequest(identifier: "snooze", content: newContent, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequest, withCompletionHandler: nil)

            
        }
        
        completionHandler()
    }
    
    // notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
    }
    
    
    func setCategories(){
        let completeAction = UNNotificationAction(
            identifier: "complete",
            title: "Remind me later",
            options: [])
        
        let taskCategory = UNNotificationCategory(
            identifier: "task.category",
            actions: [completeAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories([taskCategory])
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

