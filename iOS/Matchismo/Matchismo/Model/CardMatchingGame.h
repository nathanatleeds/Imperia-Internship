//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 5.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck*) deck;

-(void)chooseCardAtIndex: (NSUInteger) index;
-(Card *)cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end
