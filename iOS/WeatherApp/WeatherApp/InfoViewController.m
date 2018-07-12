//
//  InfoViewController.m
//  WeatherApp
//
//  Created by slaviyana chervenkondeva on 12.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "InfoViewController.h"
#import "WeekTableViewCell.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *temperature;
@property (weak, nonatomic) IBOutlet UITableView *weekTable;

@end

@implementation InfoViewController


#pragma mark - Image
-(void)setImage
{
    
   self.imageView.image = [UIImage imageNamed:@"sun.png"];
    NSLog(@"Image");
}

-(void)setTemperature:(UITextView *)temperature
{
    temperature.text = @"30 C";
}

#pragma mark - Table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Week Cell";
    WeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] ;

    
//
    return cell;
//}

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setImage];
    [self.weekTable registerNib:[UINib nibWithNibName:NSStringFromClass([WeekTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Week Cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
