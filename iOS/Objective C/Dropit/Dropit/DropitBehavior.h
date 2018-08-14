//
//  Dropit.h
//  Dropit
//
//  Created by slaviyana chervenkondeva on 9.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior


-(void)addItem: (id <UIDynamicItem>)item;
-(void)removeItem:(id <UIDynamicItem>)item;


@end
