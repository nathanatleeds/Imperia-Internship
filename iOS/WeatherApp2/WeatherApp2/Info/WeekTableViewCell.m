//
//  WeekTableViewCell.m
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "WeekTableViewCell.h"

@implementation WeekTableViewCell


-(void)populate: (NSString *)date imageCode: (NSString *)code maxTemp: (NSString *)max minTemp:(NSString *)min
{
    self.dateText.text = date;
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/64/%@.png", code]]];
    self.weatherIcon.image = [UIImage imageWithData: imageData];
    
    self.maxTempText.text = max;
    self.minTempText.text = min;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
