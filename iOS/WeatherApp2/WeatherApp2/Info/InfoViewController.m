//
//  InfoViewController.m
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 16.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "InfoViewController.h"
#import "ServerCommunicationManager.h"
#import "WeekTableViewCell.h"

@interface InfoViewController () <ServerCommunicationDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *tempText;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UITableView *weekTable;
@property (strong, nonatomic) NSMutableArray *weekData;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.weekTable registerNib:[UINib nibWithNibName:NSStringFromClass([WeekTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WeekTableViewCell class])];
    NSLog(@"%ld", self.woeid);
         [[ServerCommunicationManager sharedInstance] sendRequest:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/%ld/", self.woeid] delegate:self];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didReceiveMyResponse:(id)dataInfo
{
    //NSLog(@"%@", dataInfo);
    if([dataInfo isKindOfClass: [NSDictionary class]])
    {
        self.weekData = [dataInfo objectForKey: @"consolidated_weather"];
        
        self.title = [dataInfo objectForKey: @"title"];
        NSDictionary *currentWeather = [dataInfo objectForKey: @"consolidated_weather"][0];
        NSString *currentTemp = [currentWeather objectForKey: @"the_temp"];
        //NSLog(@"%@", currentTemp);
        self.tempText.text = [NSString stringWithFormat: @"%@ Cº", currentTemp];
        NSString *imageCode = [currentWeather objectForKey: @"weather_state_abbr"];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/%@.png", imageCode]]];
        self.weatherImage.image = [UIImage imageWithData: imageData];
        [self.weekTable reloadData];
    }
    
}

#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weekData count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WeekTableViewCell class]) forIndexPath:indexPath] ;
    
    NSString *date = [self.weekData objectAtIndex:indexPath.row][@"applicable_date"];
    NSString *imgCode =[self.weekData objectAtIndex:indexPath.row][@"weather_state_abbr"];
    NSString *max = [NSString stringWithFormat:@"%f", [[self.weekData objectAtIndex:indexPath.row][@"max_temp"] doubleValue]];
    NSString *min = [NSString stringWithFormat:@"%f", [[self.weekData objectAtIndex:indexPath.row][@"min_temp"] doubleValue]];
    //NSLog(@"%@", min);
    
    [cell populate:date imageCode:imgCode maxTemp:max minTemp:min];


    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
