//
//  WeekTableViewCell.h
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *dateText;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UITextView *maxTempText;
@property (weak, nonatomic) IBOutlet UITextView *minTempText;

-(void)populate: (NSString *)date imageCode: (NSString *)code maxTemp: (NSString *)max minTemp:(NSString *)min;

@end
