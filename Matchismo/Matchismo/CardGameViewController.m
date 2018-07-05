//
//  ViewController.m
//  Matchismo
//
//  Created by slaviyana chervenkondeva on 4.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "CardGameViewController.h"
#import "Card.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *gameButton;



@end

@implementation CardGameViewController

- (IBAction)gameTouch:(id)sender
{
    _game = nil;
    [self updateUI];
}


-(CardMatchingGame *) game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount: [self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

-(Deck *) createDeck
{
    return [PlayingCardDeck new];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}



-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

-(NSString *) titleForCard:(Card *) card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
- (IBAction)newGameButton:(id)sender {
}
@end
