//
//  PlayingCardView.h
//  SuperCard
//
//  Created by slaviyana chervenkondeva on 9.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView


@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

-(void) pinch:(UIPinchGestureRecognizer *)gesture;
@end
