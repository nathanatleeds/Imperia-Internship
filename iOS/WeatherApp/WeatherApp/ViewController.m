//
//  ViewController.m
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *totalData;
@property (strong, nonatomic) NSMutableArray *filteredData;
@property BOOL isFiltered;
@end

@implementation ViewController

- (void)viewDidLoad {

    
    
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

}

#pragma mark - Search Bar

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
      //  self.isFiltered = NO;
    }
    else
    {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/search/?query=%@", searchText]]];
        [request setHTTPMethod:@"GET"];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
         ^(NSData * _Nullable data,
           NSURLResponse * _Nullable response,
           NSError * _Nullable error) {
             
            self.totalData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
         }] resume];
        [self.tableView reloadData];
    }
    
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.totalData count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if(!cell)
    {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        cell.textLabel.text = [self.totalData objectAtIndex:indexPath.row][@"title"];
        cell.detailTextLabel.text = [self.totalData objectAtIndex:indexPath.row][@"latt_long"];

    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareInfoViewController:(InfoViewController *)ivc
{
    ivc.title = @"City";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath)
        {
            if([segue.identifier isEqualToString:@"Display Info"])
            {
                if([segue.destinationViewController isKindOfClass:[InfoViewController class]])
                {
                    NSInteger woeid = [[self.totalData objectAtIndex:indexPath.row][@"woeid"] integerValue];
                    
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/%ld", woeid]]];
                    [request setHTTPMethod:@"GET"];
                    
                    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
                      ^(NSData * _Nullable data,
                        NSURLResponse * _Nullable response,
                        NSError * _Nullable error) {
                          
                          NSDictionary *cityInfo = [NSDictionary new];
                          cityInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                          //NSLog(@"%@", cityInfo);
                          
                          NSArray *weather = [cityInfo objectForKey:@"consolidated_weather"];
                          
                          NSDictionary *currentTemp = [weather firstObject];
                          float currentMax = [[currentTemp objectForKey:@"max_temp"] floatValue];
                          
                          NSLog(@"%f", currentMax);
                          
                      }] resume];
                    
                   // [self prepareInfoViewController:segue.destinationViewController];//[@"woeid"]];
                }
            }
        }
    }
}

@end
