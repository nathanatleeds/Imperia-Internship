//
//  AppDelegate.h
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 16.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end
