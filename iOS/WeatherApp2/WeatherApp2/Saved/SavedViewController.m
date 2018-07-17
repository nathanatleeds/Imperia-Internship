//
//  SavedViewController.m
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 16.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "SavedViewController.h"
#import "ServerCommunicationManager.h"
#import "SavedTableViewCell.h"
#import "ViewController.h"
#import "InfoViewController.h"

@interface SavedViewController () <ServerCommunicationDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSUserDefaults *defaults;
@property (weak, nonatomic) IBOutlet UITableView *savedTable;
@property (nonatomic, strong) NSMutableArray *savedWeather;
@property (nonatomic, strong) NSMutableArray *savedId;
@property (nonatomic, strong) NSMutableArray *savedNames;
@property (weak, nonatomic) IBOutlet UIButton *savedButton;

@end

@implementation SavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.savedTable.allowsMultipleSelectionDuringEditing = NO;
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self.savedTable registerNib:[UINib nibWithNibName:NSStringFromClass([SavedTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SavedTableViewCell class])];
    
    for(NSNumber *num in [self.defaults objectForKey:@"Saved"])
    {
        NSLog(@"%@", num);
        [[ServerCommunicationManager sharedInstance] sendRequest:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/%@/", num] delegate:self];

    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        //[self.savedTable removeObjectAtIndex:indexPath.row];
        [self.savedId removeObjectAtIndex:indexPath.row];
        [self.savedNames removeObjectAtIndex:indexPath.row];
        [self.savedWeather removeObjectAtIndex:indexPath.row];
        [self.defaults setObject:self.savedId forKey:@"Saved"];
        [self.defaults synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


-(void)resetDefaults {
    NSDictionary * dict = [self.defaults dictionaryRepresentation];
    for (id key in dict) {
        [self.defaults removeObjectForKey:key];
    }
    [self.defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.savedWeather count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SavedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SavedTableViewCell class]) forIndexPath:indexPath];
    NSString *placeName = [self.savedNames objectAtIndex:indexPath.row];
    NSString *imgCode =[self.savedWeather objectAtIndex:indexPath.row][@"weather_state_abbr"];
    float temp = [[self.savedWeather objectAtIndex:indexPath.row][@"the_temp"] floatValue];
   [cell populate:placeName imageCode:imgCode temp:temp];
//
    
    return cell;
}


#pragma mark - Request Handler
-(NSMutableArray *)savedNames
{
    if(!_savedNames) _savedNames = [NSMutableArray new];

    return _savedNames;
}

-(NSMutableArray *)savedWeather
{
    if(!_savedWeather) _savedWeather = [NSMutableArray new];
    
    return _savedWeather;
}

-(NSMutableArray *)savedId
{
    if(!_savedId) _savedId = [NSMutableArray new];
    
    return _savedId;
}

-(void)didReceiveMyResponse:(id)dataInfo
{
    if([dataInfo isKindOfClass: [NSDictionary class]])
    {
        NSDictionary *currentWeather = [dataInfo objectForKey: @"consolidated_weather"][0];
        [self.savedId addObject:[dataInfo objectForKey:@"woeid"]];

        [self.savedNames addObject:[dataInfo objectForKey: @"title"]];
        
        [self.savedWeather addObject: currentWeather];
        
        //NSLog(@"%@", self.savedNames);
        [self.savedTable reloadData];

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Do whatever you like with indexpath.row
    
    InfoViewController *infoScreen = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
    NSInteger woeid = [[self.savedId objectAtIndex:indexPath.row] integerValue];
    infoScreen.woeid = woeid;
    [self.navigationController pushViewController:infoScreen animated:YES];
}

- (IBAction)clickedAdd:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ViewController *newView = [storyboard instantiateViewControllerWithIdentifier:@"SearchView"];
    [self.navigationController pushViewController:newView animated:YES];
    
    
//    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([ViewController class])];
//    [self.navigationController pushViewController:vc animated:YES];
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
