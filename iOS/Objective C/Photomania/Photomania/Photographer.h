//
//  Photographer.h
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@class Photo;


@interface Photographer : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Photographer (CoreDataGeneratedAccessors)

-(void) addPhotosObject: (Photo *)value;
-(void)removePhotosObject: (Photo *)value;
-(void)addPhotos:(NSSet *)values;
-(void)removePhotos:(NSSet *)values;

@end
