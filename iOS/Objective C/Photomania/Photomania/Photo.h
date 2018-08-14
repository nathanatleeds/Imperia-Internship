//
//  Photo.h
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *subtitle;
@property (nonatomic, retain)NSString *imageURL;
@property (nonatomic, retain)NSString *unique;
@property (nonatomic, retain)Photographer *whoTook;

@end
