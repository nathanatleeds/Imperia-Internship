//
//  BezierPathView.m
//  Dropit
//
//  Created by slaviyana chervenkondeva on 10.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView


-(void)setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.path stroke];
}


@end
