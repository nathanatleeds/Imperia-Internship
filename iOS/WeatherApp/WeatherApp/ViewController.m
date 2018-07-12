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
    
    _totalData = [[NSMutableArray alloc] initWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", nil];
}

#pragma mark - Search Bar

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        self.isFiltered = NO;
    }
    else
    {
        self.isFiltered = YES;
        self.filteredData = [[NSMutableArray alloc] init];
        
        for(NSString *str in self.totalData)
        {
            NSRange dataRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(dataRange.location != NSNotFound)
            {
                [self.filteredData addObject:str];
            }
        }
    }
    
    [self.tableView reloadData];
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
    if(self.isFiltered)
    {
        return [self.filteredData count];
    }
    else
    {
        return [self.totalData count];
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(!self.isFiltered)
    {
        cell.textLabel.text = [self.totalData objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.filteredData objectAtIndex:indexPath.row];
    }
    
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
                    [self prepareInfoViewController:segue.destinationViewController];
                }
            }
        }
    }
}

@end
