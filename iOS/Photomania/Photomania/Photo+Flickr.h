//
//  Photo+Flickr.h
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+(Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context;

+(void)loadPhotosFromFlickrArray:(NSArray *)photos //of Flickr NSDictionary
        intoManagedObjectContext:(NSManagedObjectContext *) context;

@end
