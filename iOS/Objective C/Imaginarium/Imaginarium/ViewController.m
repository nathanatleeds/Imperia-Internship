//
//  ViewController.m
//  Imaginarium
//
//  Created by slaviyana chervenkondeva on 10.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()
@end

@implementation ViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ImageViewController class]])
    {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://cdn.pixabay.com/photo/2018/03/12/14/03/flower-3219718_960_720.jpg"]];
        ivc.title = segue.identifier;
    }
}


@end
