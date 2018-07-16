//
//  SavedViewController.m
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "SavedViewController.h"
#import "SavedTableViewCell.h"

@interface SavedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *savedTable;

@end

@implementation SavedViewController

#pragma mark - Table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SavedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SavedTableViewCell class]) forIndexPath:indexPath] ;
    
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.savedTable registerNib:[UINib nibWithNibName:NSStringFromClass([SavedTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SavedTableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
