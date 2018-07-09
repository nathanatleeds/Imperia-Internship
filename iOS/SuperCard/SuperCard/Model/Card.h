//
//  Card.h
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 4.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isMatched) BOOL mathced;
@property (nonatomic, getter=isChosen) BOOL chosen;

- (int) match:(NSArray *) otherCards;

@end
