//
//  ViewController.h
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 4.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

-(Deck *) createDeck;  // abstract
@end

