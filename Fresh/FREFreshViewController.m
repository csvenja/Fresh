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
    food1.freshDays = @3;

    FREFood *food2 = [[FREFood alloc] init];
    food2.name = @"cherry";
    food2.productionDate = [NSDate date];
    food2.freshDays = @3;

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
    cell.textLabel.text = [self.foods[indexPath.row] name];
    NSInteger elapsedDays = [[NSDate date] timeIntervalSinceDate:[self.foods[indexPath.row] productionDate]] / 60 / 60 / 24;
    NSInteger remainDays = [self.foods[indexPath.row] freshDays].integerValue - elapsedDays;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld day%@", remainDays, remainDays < 1 ? @"" : @"s"];

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
