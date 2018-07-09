//
//  PlayingCard.h
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 5.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic) NSInteger rank;
@property (strong, nonatomic) NSString *suit;

+(NSUInteger) maxRank;
+(NSArray *) validSuits;

@end
