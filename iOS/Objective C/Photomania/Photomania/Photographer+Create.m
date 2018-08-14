//
//  Photographer+Create.m
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "Photographer+Create.h"

@implementation Photographer (Create)

+ (Photographer *)photographerWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = nil;
    
    if([name length])
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if(!matches || error || ([matches count] > 1))
        {
            // handle error
        }
        else if([matches count])
        {
            photographer = [matches lastObject]; 
        }
        else
        {
            photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
            photographer.name = name;
            
        }
    }
    return photographer;
}

@end
