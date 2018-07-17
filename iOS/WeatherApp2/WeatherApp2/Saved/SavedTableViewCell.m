//
//  SavedTableViewCell.m
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "SavedTableViewCell.h"

@implementation SavedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)populate: (NSString *)place imageCode: (NSString *)code temp: (float)temp
{
    self.placeText.text = place;
    self.tenpText.text = [NSString stringWithFormat:@"%f", temp];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/%@.png", code]]];
    self.weatherImage.image = [UIImage imageWithData: imageData];
}
@end
