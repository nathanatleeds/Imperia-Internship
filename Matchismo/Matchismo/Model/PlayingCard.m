//
//  PlayingCard.m
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 5.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger) maxRank
{
    return [[self rankStrings]count] - 1;
}

-(void) setRank:(NSInteger)rank
{
    if(rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

+(NSArray *) validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

@synthesize suit = _suit;

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit: @"?";
}

@end
