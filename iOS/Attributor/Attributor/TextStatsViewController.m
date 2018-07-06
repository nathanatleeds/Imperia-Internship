//
//  TextStatsViewController.m
//  Attributor
//
//  Created by slaviyana chervenkondeva on 6.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController


- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
      if (self.view.window) [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%ld colorful characters",[[self charactersWithAttribute: NSForegroundColorAttributeName]length]];
    
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%ld outlined characters",[[self charactersWithAttribute: NSStrokeWidthAttributeName]length]];
}

-(NSAttributedString *) charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc]init];
    int index = 0;
    while (index < [self.textToAnalyze length])
    {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value)
        {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)(range.location + range.length);
        }
        else
        {
            index++;
        }
    }
    return characters;
}



@end
