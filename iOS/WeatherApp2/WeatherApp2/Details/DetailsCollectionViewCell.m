//
//  CollectionViewCell.m
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 17.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "DetailsCollectionViewCell.h"

@implementation DetailsCollectionViewCell

-(void)populate: (NSString *)time imageCode: (NSString *)code temp: (float)temp humidity: (float)humid windSpeed: (float)wSpeed windDirection: (NSString *)wDirection
{
    self.timeLabel.text = time;
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/%@.png", code]]];
    self.imageView.image = [UIImage imageWithData: imageData];
    
    self.tempLabel.text = [NSString stringWithFormat:@"%f Cº", temp];
    self.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %f", humid];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"Wind speed: %f", wSpeed];
    self.windDirectionLabel.text = [NSString stringWithFormat:@"Wind direction: %@", wDirection];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
