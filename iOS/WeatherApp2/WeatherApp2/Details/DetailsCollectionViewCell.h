//
//  CollectionViewCell.h
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 17.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsCollectionViewCell : UICollectionViewCell

-(void)populate: (NSString *)time imageCode: (NSString *)code temp: (float)temp humidity: (float)humid windSpeed: (float)wSpeed windDirection: (NSString *)wDirection;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
