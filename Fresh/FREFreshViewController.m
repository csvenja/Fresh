//
//  FREFreshViewController.m
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import "FREFreshViewController.h"

@interface FREFreshViewController ()

@end

@implementation FREFreshViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    FREFood *food1 = [[FREFood alloc] init];
    food1.name = @"pork";
    food1.productionDate = [NSDate date];
    food1.freshDays = [[NSDateComponents alloc] init];
    food1.freshDays.day = 3;
    food1.notification = [[UILocalNotification alloc] init];

    FREFood *food2 = [[FREFood alloc] init];
    food2.name = @"cherry";
    food2.productionDate = [NSDate date];
    food2.freshDays = [[NSDateComponents alloc] init];
    food2.freshDays.day = 3;
    food2.notification = [[UILocalNotification alloc] init];

    self.foods = [@[food1, food2] mutableCopy];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell" forIndexPath:indexPath];
    FREFood *food = self.foods[indexPath.row];
    cell.textLabel.text = food.name;

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *elapsed = [calendar components:NSDayCalendarUnit fromDate:food.productionDate toDate:[NSDate date] options:0];
    NSInteger remainDays = food.freshDays.day - elapsed.day;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld day%@", remainDays, fabs(remainDays) < 2 ? @"" : @"s"];
    cell.detailTextLabel.textColor = remainDays < 0 ? [UIColor redColor] : [UIColor grayColor];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.foods removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        [segue.destinationViewController setFood:[self.foods objectAtIndex:indexPath.row]];
        [segue.destinationViewController setTitle:[self.foods[indexPath.row] name]];
        [segue.destinationViewController setFunction:FREDetailViewFunctionEdit];
    }
    else {
        [segue.destinationViewController setTitle:@"Add"];
        [segue.destinationViewController setFunction:FREDetailViewFunctionAdd];
        [segue.destinationViewController setFoods:self.foods];
    }
}

@end
