//
//  FREDetailViewController.m
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import "FREDetailViewController.h"

const int defaultFreshDays = 3;

@interface FREDetailViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIStepper *daysStepper;

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

- (void)updateNotification
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *notificationDays = [[NSDateComponents alloc] init];
    notificationDays.day = self.food.freshDays.day / 5;
    if (notificationDays.day < 1) {
        notificationDays.day = 1;
    }
    NSDate *fireDate = [calendar dateByAddingComponents:notificationDays toDate:self.food.productionDate options:0];

    if ([[[NSDate date] earlierDate:fireDate] isEqualToDate:fireDate]) {
        self.food.notification.alertBody = [NSString stringWithFormat:@"%@ expired!", self.food.name];
    }
    else {
        self.food.notification.alertBody = [NSString stringWithFormat:@"%@ almost expired!", self.food.name];
    }

    self.food.notification.fireDate = fireDate;
    self.food.notification.timeZone = [NSTimeZone localTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:self.food.notification];
}

- (void)updateFreshDaysField
{
    self.freshDaysField.text = [NSString stringWithFormat:@"%ld day%@",
                                self.food.freshDays.day,
                                self.food.freshDays.day < 2 ? @"" : @"s"];
}

- (void)updateProductionDateField
{
    self.productionDateField.text = [NSDateFormatter localizedStringFromDate:self.food.productionDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.function == FREDetailViewFunctionEdit) {
        self.nameField.text = self.food.name;
    }
    else {
        self.food = [[FREFood alloc] init];
        self.food.productionDate = [NSDate date];
        self.food.freshDays = [[NSDateComponents alloc] init];
        self.food.freshDays.day = defaultFreshDays;
        self.food.notification = [[UILocalNotification alloc] init];

        [self.nameField becomeFirstResponder];
    }

    self.productionDateField.inputView = self.datePicker;
    self.datePicker.date = self.food.productionDate;
    [self updateFreshDaysField];
    [self updateProductionDateField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *clickedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([clickedCell isEqual:self.submitCell]) {
        self.food.name = self.nameField.text;
        [self updateNotification];
        if (self.function == FREDetailViewFunctionAdd) {
            [self.foods insertObject:self.food atIndex:0];
        }
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)dateChanged:(UIDatePicker *)sender
{
    self.food.productionDate = sender.date;
    [self updateProductionDateField];
}

- (IBAction)daysChanged:(UIStepper *)sender
{
    self.food.freshDays.day = (int)sender.value;
    [self updateFreshDaysField];
}

@end
