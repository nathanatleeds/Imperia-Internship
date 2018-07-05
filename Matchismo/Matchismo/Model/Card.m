//
//  Card.m
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 4.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if([self.contents isEqualToString:card.contents])
            {
                score = 1;
            }
    }
    return score;
}

@end
