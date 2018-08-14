//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 5.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@end

@implementation CardMatchingGame

-(NSMutableArray *) cards
{
    if(!_cards) _cards = [NSMutableArray new];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck*) deck;
{
    self = [super init];
    
    if(self)
    {
        for (int i = 0; i < count; i++)
        {
            Card* card = [deck drawRandomCard];
            if(card)
            {
                 [self.cards addObject:card];
            }
            else
            {
                self=nil;
                break;
            }
           
        }
    }
    
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            for(Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match: @[otherCard]];
                    if(matchScore)
                    {
                        self.score += matchScore * MATCH_BONUS;
                        card.mathced = YES;
                        otherCard.mathced = YES;
                        break;
                        
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    
                }

            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}


@end
