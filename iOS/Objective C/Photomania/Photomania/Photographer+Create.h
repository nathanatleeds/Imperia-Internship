//
//  Photographer+Create.h
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Create)

+ (Photographer *)photographerWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
