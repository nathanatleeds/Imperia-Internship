//
//  ViewController.m
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "ServerCommunicationManager.h"
#import "ViewController.h"
#import "InfoViewController.h"
#import "SavedViewController.h"

@interface ViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *totalData;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"Saved"] && [[defaults objectForKey:@"Saved"] count])
    {
        SavedViewController *savedScreen = [[SavedViewController alloc]initWithNibName:@"SavedViewController" bundle:nil];
        NSLog(@"%@", self.navigationController.childViewControllers);
        NSMutableArray *contr = [NSMutableArray arrayWithArray:self.navigationController.childViewControllers];
        contr[0] = savedScreen;
        [self.navigationController setViewControllers:contr];
//        [self.navigationController pushViewController:savedScreen animated:YES];
    }
    
}

#pragma mark - Search Bar

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", searchText);
    if(searchText.length == 0)
    {
    }
    else
    {
         [[ServerCommunicationManager sharedInstance] sendRequest:[NSString stringWithFormat: @"https://www.metaweather.com/api/location/search/?query=%@", searchText] delegate:self];
        
       // [self.tableView reloadData];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Do whatever you like with indexpath.row
    
    InfoViewController *infoScreen = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
    NSInteger woeid = [[self.totalData objectAtIndex:indexPath.row][@"woeid"] integerValue];
    infoScreen.woeid = woeid;
    [self.navigationController pushViewController:infoScreen animated:YES];
}


#pragma mark - Response Handler
-(void)didReceiveMyResponse:(id)dataInfo
{
    //NSLog(@"%@", dataInfo);
    if([dataInfo isKindOfClass: [NSArray class]])
    {
        self.totalData = dataInfo;
        [self.tableView reloadData];
    }
    
}


@end
