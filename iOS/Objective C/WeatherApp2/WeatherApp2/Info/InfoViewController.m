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
#import "DetailsViewController.h"
#import "SavedViewController.h"
#import "ViewController.h"
#import "MBProgressHUD.h"

@interface InfoViewController () <ServerCommunicationDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *tempText;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UITableView *weekTable;
@property (strong, nonatomic) NSMutableArray *weekData;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.weekTable registerNib:[UINib nibWithNibName:NSStringFromClass([WeekTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WeekTableViewCell class])];
    // NSLog(@"%ld", self.woeid);
    [[ServerCommunicationManager sharedInstance] sendRequest:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/%ld/", self.woeid] delegate:self];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request Handler
-(void)didReceiveMyResponse:(id)dataInfo
{
    //NSLog(@"%@", dataInfo);
    if([dataInfo isKindOfClass: [NSDictionary class]])
    {
        self.weekData = [dataInfo objectForKey: @"consolidated_weather"];
        
        self.title = [dataInfo objectForKey: @"title"];
        NSDictionary *currentWeather = [dataInfo objectForKey: @"consolidated_weather"][0];
        NSString *currentTemp = [currentWeather objectForKey: @"the_temp"];
        NSString *date = currentWeather[@"applicable_date"];
        //NSLog(@"%@", currentTemp);
        self.dateLabel.text = date;
        self.tempText.text = [NSString stringWithFormat: @"%@ Cº", currentTemp];
        NSString *imageCode = [currentWeather objectForKey: @"weather_state_abbr"];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"https://www.metaweather.com/static/img/weather/png/%@.png", imageCode]]];
        self.weatherImage.image = [UIImage imageWithData: imageData];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *cityId = [NSMutableArray new];
        
        if([defaults objectForKey:@"Saved"])
        {
            cityId = [NSMutableArray arrayWithArray:[defaults objectForKey:@"Saved"]];
        }
        
        NSNumber *newId = [NSNumber numberWithInteger:self.woeid];
        if([cityId containsObject:newId]) {
            NSLog(@"Contains");
            UIImage *btnImage = [UIImage imageNamed:@"saved.png"];
            [self.saveButton setBackgroundImage:btnImage forState:UIControlStateNormal];
        }
        else {
            NSLog(@"Not Contains");
            UIImage *btnImage = [UIImage imageNamed:@"not_saved.png"];
            [self.saveButton setBackgroundImage:btnImage forState:UIControlStateNormal];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self.weekTable reloadData];
        });
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
    NSString *max = [NSString stringWithFormat:@"%ld Cº", lroundf([[self.weekData objectAtIndex:indexPath.row][@"max_temp"] doubleValue])];
    NSString *min = [NSString stringWithFormat:@"%ld Cº", lroundf([[self.weekData objectAtIndex:indexPath.row][@"min_temp"] doubleValue])];
    //NSLog(@"%@", min);
    
    [cell populate:date imageCode:imgCode maxTemp:max minTemp:min];
    
    
    return cell;
}

- (IBAction)showDertails:(UIButton *)sender
{
    DetailsViewController *detailsScreen = [[DetailsViewController alloc]initWithNibName:@"DetailsViewController" bundle:nil];
    detailsScreen.woeid = self.woeid;
    detailsScreen.date = self.dateLabel.text;
    [self.navigationController pushViewController:detailsScreen animated:YES];
}

-(void)deleteCity: (NSMutableArray *)cityId defaults: (NSUserDefaults *)defaults {
    
    UIImage *btnImage = [UIImage imageNamed:@"not_saved.png"];
    [self.saveButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    for (int i = 0; i < [cityId count]; i++) {
        NSNumber *newId = [NSNumber numberWithInteger:self.woeid];
        if(newId == cityId[i]) {
            [cityId removeObjectAtIndex: i];
            [defaults setObject:cityId forKey:@"Saved"];
            
            [defaults synchronize];
            break;
        }
    }
    SavedViewController *savedScreen = [[SavedViewController alloc]initWithNibName:@"SavedViewController" bundle:nil];
    //   NSInteger woeid = [[self.totalData objectAtIndex:indexPath.row][@"woeid"] integerValue];
    
    [self.navigationController pushViewController:savedScreen animated:YES];
}

- (IBAction)saveCity:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cityId = [NSMutableArray new];
    
    
    if([defaults objectForKey:@"Saved"])
    {
        cityId = [NSMutableArray arrayWithArray:[defaults objectForKey:@"Saved"]];
    }
    
    NSNumber *newId = [NSNumber numberWithInteger:self.woeid];
    if([cityId containsObject:newId]) {
        
        // alert
        NSString *title = @"Remove City";
        NSString *message = @"Are you sure you want to delete this city from your saved cities?";
        NSString *confirmText = @"Delete";
        NSString *quitText = @"Cancel";
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
        
        //        UIAlertAction *delete = [UIAlertAction actionWithTitle:(nullable NSString *) style:(UIAlertActionStyle) handler:^(UIAlertAction * _Nonnull action) {
        
        //  }]
        UIAlertAction *delete = [UIAlertAction actionWithTitle: confirmText style:UIAlertActionStyleDefault handler: ^(UIAlertAction *doing) {
            [self deleteCity:cityId defaults:defaults];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle: quitText style:UIAlertActionStyleCancel handler: nil];
        
        [alert addAction:delete];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else {
        UIImage *btnImage = [UIImage imageNamed:@"saved.png"];
        [self.saveButton setBackgroundImage:btnImage forState:UIControlStateNormal];
        [cityId addObject:newId];
        [defaults setObject:cityId forKey:@"Saved"];
        
        [defaults synchronize];
        
    }
    
    NSLog(@"%@", [defaults objectForKey:@"Saved"]);
    
    SavedViewController *savedScreen = [[SavedViewController alloc]initWithNibName:@"SavedViewController" bundle:nil];
    //   NSInteger woeid = [[self.totalData objectAtIndex:indexPath.row][@"woeid"] integerValue];
    
    [self.navigationController pushViewController:savedScreen animated:YES];
    
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
