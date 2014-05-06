//
//  FREFood.h
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FREFood : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSDate *productionDate;
@property (nonatomic) NSDateComponents *freshDays;
@property (nonatomic) UILocalNotification *notification;

@end
