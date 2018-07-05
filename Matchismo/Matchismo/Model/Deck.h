//
//  Deck.h
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 5.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card;
-(void) addCard:(Card *)card atTop:(BOOL) atTop;

-(Card *) drawRandomCard;

@end
