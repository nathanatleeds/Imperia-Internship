//
//  SavedTableViewCell.h
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedTableViewCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *placeText;

@property (unsafe_unretained, nonatomic) IBOutlet UITextView *tenpText;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *weatherImage;

-(void)populate: (NSString *)place imageCode: (NSString *)code temp: (float)temp;

@end
