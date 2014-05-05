//
//  FREDetailViewController.m
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import "FREDetailViewController.h"

@interface FREDetailViewController ()

@end

@implementation FREDetailViewController

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

    if (self.function == FREDetailViewFunctionEdit) {
        self.nameField.text = self.food.name;
        self.productionDateField.text = [NSDateFormatter localizedStringFromDate:self.food.productionDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
        self.freshDaysField.text = [NSString stringWithFormat:@"%@ day%@",
                                    self.food.freshDays,
                                    self.food.freshDays.integerValue < 1 ? @"" : @"s"];
    }
    else {
        self.food = [[FREFood alloc] init];
        self.food.productionDate = [NSDate date];
        self.productionDateField.text = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
        self.food.freshDays = @3;
        [self.nameField becomeFirstResponder];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *clickedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([clickedCell isEqual:self.submitCell]) {
        self.food.name = self.nameField.text;
        if (self.function == FREDetailViewFunctionAdd) {
            [self.foods insertObject:self.food atIndex:0];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
