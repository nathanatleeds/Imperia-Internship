//
//  DetailsViewController.m
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 16.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsCollectionViewCell.h"
#import "ServerCommunicationManager.h"
#import "ViewController.h"

@interface DetailsViewController () <ServerCommunicationDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *hoursCollectionView;
@property (strong, nonatomic) NSMutableArray *hoursData;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.date;
    [self.hoursCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailsCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DetailsCollectionViewCell class])];

    NSLog(@"%@ %ld", self.date, (long)self.woeid);
    
    NSString *formattedDate = [self.date stringByReplacingOccurrencesOfString:@"-"
                                                             withString:@"/"];
    
    NSLog(@"%@", formattedDate);
    [[ServerCommunicationManager sharedInstance] sendRequest:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/%ld/%@/", self.woeid, formattedDate] delegate:self];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.hoursData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DetailsCollectionViewCell class]) forIndexPath:indexPath];
    
    NSString *time = [self.hoursData objectAtIndex:indexPath.row][@"created"];
    NSString *imgCode =[self.hoursData objectAtIndex:indexPath.row][@"weather_state_abbr"];
    float temp = [[self.hoursData objectAtIndex:indexPath.row][@"the_temp"] floatValue];
    float humidity = [[self.hoursData objectAtIndex:indexPath.row][@"humidity"] floatValue];
    float windSpeed = [[self.hoursData objectAtIndex:indexPath.row][@"wind_speed"] floatValue];
    NSString *wDirection = [self.hoursData objectAtIndex:indexPath.row][@"wind_direction_compass"];

    [cell populate:time imageCode:imgCode temp:temp humidity:humidity windSpeed:windSpeed windDirection:wDirection];
    
    return cell;
}


#pragma mark - Request Handler
-(void)didReceiveMyResponse:(id)dataInfo
{
    if(dataInfo == nil)
    {
        ViewController *searchScreen = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        //   NSInteger woeid = [[self.totalData objectAtIndex:indexPath.row][@"woeid"] integerValue];

        [self.navigationController pushViewController:searchScreen animated:YES];
    }
    else
    {
        self.hoursData = dataInfo;
        [self.hoursCollectionView reloadData];
    }
    
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
