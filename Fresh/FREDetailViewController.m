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

    if (self.food) {
        self.nameField.text = self.food.name;
        self.productionDateField.text = [NSDateFormatter localizedStringFromDate:self.food.productionDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
        self.freshDaysField.text = [NSString stringWithFormat:@"%@ day%@",
                                        self.food.freshDays,
                                        self.food.freshDays.integerValue < 1 ? @"" : @"s"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
