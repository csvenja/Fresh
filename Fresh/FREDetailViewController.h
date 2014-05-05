//
//  FREDetailViewController.h
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FREFood.h"

typedef NS_ENUM(NSInteger, FREDetailViewFunction) {
    FREDetailViewFunctionAdd,
    FREDetailViewFunctionEdit
};

@interface FREDetailViewController : UITableViewController

@property (nonatomic) FREFood *food;
@property (weak, nonatomic) NSMutableArray *foods;
@property (nonatomic) FREDetailViewFunction function;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *productionDateField;
@property (weak, nonatomic) IBOutlet UILabel *freshDaysField;
@property (weak, nonatomic) IBOutlet UITableViewCell *submitCell;

@end
