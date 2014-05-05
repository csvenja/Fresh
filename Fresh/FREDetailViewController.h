//
//  FREDetailViewController.h
//  Fresh
//
//  Created by Svenja on 2014-05-04.
//  Copyright (c) 2014 Shan Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FREFood.h"

@interface FREDetailViewController : UITableViewController

@property (weak, nonatomic) FREFood *food;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *productionDateField;
@property (weak, nonatomic) IBOutlet UILabel *freshDaysField;
@property (weak, nonatomic) IBOutlet UITableViewCell *submit;

@end
