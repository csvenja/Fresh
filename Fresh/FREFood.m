//
//  FREFood.m
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import "FREFood.h"

@implementation FREFood

- (id)init
{
    self = [super init];
    return self;
}

- (NSInteger)remainDays
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *elapsed = [calendar components:NSDayCalendarUnit fromDate:self.productionDate toDate:[NSDate date] options:0];
    return self.freshDays.day - elapsed.day;
}

- (void)updateNotification
{
    if (self.notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:self.notification];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *notificationDays = [[NSDateComponents alloc] init];
    notificationDays.day = self.freshDays.day / 5;
    if (notificationDays.day < 1) {
        notificationDays.day = 1;
    }
    NSDate *fireDate = [calendar dateByAddingComponents:notificationDays toDate:self.productionDate options:0];

    if ([[[NSDate date] earlierDate:fireDate] isEqualToDate:fireDate]) {
        self.notification.alertBody = [NSString stringWithFormat:@"%@ expired!", self.name];
    }
    else {
        self.notification.alertBody = [NSString stringWithFormat:@"%@ almost expired!", self.name];
    }

    self.notification.fireDate = fireDate;
    self.notification.timeZone = [NSTimeZone localTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:self.notification];
}

@end
